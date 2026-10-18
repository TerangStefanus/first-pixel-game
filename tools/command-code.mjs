#!/usr/bin/env node
import { spawn } from 'node:child_process';
import { existsSync, readFileSync, realpathSync, statSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseArgs } from 'node:util';

const repo = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const model = 'MiniMaxAI/MiniMax-M3';
const usage = `Usage: ./tools/command-code.sh [status|version|login|interactive|models|review] [options]
  review --kind code|design --request 'Neutral question and exact files'
  review --kind design --request-file tools/local/design-question.txt
  --max-turns 8          1..30; fresh headless review
  --timeout-seconds 180  5..600 per subprocess; timeout exits 124
  --entry PATH          installed command-code/dist/index.mjs
  --node-path PATH      Node 22+ executable
Local paths default to ignored tools/local/paths.json. Login/trust are human steps.
Reviews use MiniMax M3, plan mode, no skill discovery/session persistence/auto-update.
No model fallback, trust flag, permission bypass, import or taste onboarding is added.`;

function fail(message, code = 1) {
  const error = new Error(message); error.exitCode = code; throw error;
}
function integer(value, min, max, name) {
  const n = Number(value);
  if (!Number.isInteger(n) || n < min || n > max) fail(`${name} must be ${min}..${max}.`);
  return n;
}
function requireFile(filename, label) {
  if (!filename || !existsSync(filename) || !statSync(filename).isFile()) fail(`${label} not found: ${filename || '(not configured)'}`);
  return realpathSync(filename);
}

async function main() {
  if (Number(process.versions.node.split('.')[0]) < 22) fail('Command Code requires Node 22+.');
  const { values, positionals } = parseArgs({ allowPositionals: true, options: {
    kind: { type: 'string', default: 'code' }, request: { type: 'string' },
    'request-file': { type: 'string' }, 'node-path': { type: 'string' }, entry: { type: 'string' },
    'max-turns': { type: 'string', default: '8' },
    'timeout-seconds': { type: 'string', default: '180' }, help: { type: 'boolean', default: false },
  }});
  if (values.help) { console.log(usage); return 0; }
  const mode = positionals[0] || 'status';
  if (positionals.length > 1 || !['status','version','login','interactive','models','review'].includes(mode)) fail(usage);
  if (!['code','design'].includes(values.kind)) fail('--kind must be code or design.');
  const turns = integer(values['max-turns'], 1, 30, '--max-turns');
  const timeout = integer(values['timeout-seconds'], 5, 600, '--timeout-seconds') * 1000;
  if (values.request && values['request-file']) fail('Use either --request or --request-file.');
  let request = values.request;
  if (values['request-file']) request = readFileSync(path.resolve(values['request-file']), 'utf8');
  if (mode === 'review' && !request?.trim()) fail('Review needs --request or --request-file with a neutral question and exact scope.');
  const localFile = path.join(repo, 'tools/local/paths.json');
  const local = existsSync(localFile) ? JSON.parse(readFileSync(localFile, 'utf8')) : {};
  const node = requireFile(values['node-path'] || local.NodePath || process.execPath, 'Node executable');
  let entry = values.entry || local.CommandCodeEntry;
  if (!entry) {
    const candidates = [path.resolve(path.dirname(node), '../lib/node_modules/command-code/dist/index.mjs')];
    for (const dir of (process.env.PATH || '').split(path.delimiter)) candidates.push(path.join(dir, 'command-code'));
    entry = candidates.find(filename => existsSync(filename) && statSync(filename).isFile());
  }
  entry = requireFile(entry, 'Command Code entry (configure tools/local/paths.json CommandCodeEntry)');
  const env = { ...process.env, PATH: path.dirname(node) + path.delimiter + (process.env.PATH || '') };

  function invoke(args, input = '', interactive = false) {
    return new Promise((resolve, reject) => {
      const child = spawn(node, [entry, '--no-auto-update', ...args], {
        cwd: repo, env, stdio: interactive ? 'inherit' : ['pipe','pipe','pipe'], detached: !interactive && process.platform !== 'win32',
      });
      let stdout = '', stderr = '', bytes = 0, timedOut = false, interrupted = false, overflow = false, killer;
      const stop = signal => {
        try { if (child.pid) process.platform === 'win32' || interactive ? child.kill(signal) : process.kill(-child.pid, signal); }
        catch (error) { if (error.code !== 'ESRCH') reject(error); }
      };
      const interrupt = () => { interrupted = true; stop('SIGTERM'); killer = setTimeout(() => stop('SIGKILL'), 750); };
      if (!interactive) { process.once('SIGINT', interrupt); process.once('SIGTERM', interrupt); }
      const cleanup = () => { clearTimeout(timer); clearTimeout(killer); if (!interactive) { process.removeListener('SIGINT', interrupt); process.removeListener('SIGTERM', interrupt); } };
      const timer = interactive ? null : setTimeout(() => {
        timedOut = true; stop('SIGTERM'); killer = setTimeout(() => stop('SIGKILL'), 750);
      }, timeout);
      child.on('error', error => { cleanup(); reject(error); });
      child.on('close', (code, signal) => {
        cleanup();
        if (interrupted) { stop('SIGKILL'); return resolve({ code: 130, stdout: '', stderr: 'Command Code interrupted.\n' }); }
        if (timedOut) { stop('SIGKILL'); return resolve({ code: 124, stdout: '', stderr: `Command Code exceeded ${timeout / 1000}s and was stopped.\n` }); }
        if (overflow) return resolve({ code: 1, stdout: '', stderr: 'Command Code output exceeded 16 MiB; stopped.\n' });
        resolve({ code: code ?? (signal === 'SIGINT' ? 130 : 1), stdout, stderr });
      });
      if (!interactive) {
        for (const [stream, which] of [[child.stdout,'stdout'], [child.stderr,'stderr']]) stream.on('data', chunk => {
          bytes += chunk.length;
          if (bytes > 16 * 1024 * 1024) { overflow = true; stop('SIGKILL'); return; }
          if (which === 'stdout') stdout += chunk.toString(); else stderr += chunk.toString();
        });
        child.stdin.on('error', error => { if (error.code !== 'EPIPE') reject(error); });
        child.stdin.end(input);
      }
    });
  }
  function output(result) {
    if (result.stdout) process.stdout.write(result.stdout);
    if (result.stderr) process.stderr.write(result.stderr);
    return result.code;
  }
  if (mode === 'login') return output(await invoke(['login'], '', true));
  if (mode === 'interactive') return output(await invoke(['--skip-onboarding','--no-skills','--permission-mode','plan','--model',model], '', true));
  if (mode === 'version') return output(await invoke(['--version']));
  const status = await invoke(['status','--json']);
  let auth;
  try { auth = JSON.parse(status.stdout); }
  catch { if (status.stderr) process.stderr.write(status.stderr); fail('Command Code returned invalid status JSON.', status.code || 1); }
  if (mode === 'status') {
    console.log(JSON.stringify({ authenticated: auth.authenticated === true, version: auth.version }));
    return status.code;
  }
  if (status.code !== 0 || auth.authenticated !== true) fail('Not authenticated. Run ./tools/command-code.sh login yourself, then interactive to confirm the repository. Do not use /import.', 3);
  const models = await invoke(['--list-models']);
  if (mode === 'models' || models.code !== 0) return output(models);
  if (!/(?<![A-Za-z0-9_/-])MiniMaxAI\/MiniMax-M3(?![A-Za-z0-9_/-])/i.test(models.stdout)) fail(`Required model ${model} is unavailable. No fallback model was selected.`);
  const template = values.kind === 'design' ? 'game-design-critic.md' : 'code-critic.md';
  const prompt = readFileSync(path.join(repo, 'tools/command-code/prompts', template), 'utf8') + '\n\nOwner request (fresh independent review):\n' + request + '\n';
  return output(await invoke(['-p','--model',model,'--permission-mode','plan','--skip-onboarding','--no-skills','--no-session','--max-turns',String(turns),'--output-format','text'], prompt));
}
main().then(code => { process.exitCode = code; }).catch(error => { console.error(error.message); process.exitCode = error.exitCode || 1; });
