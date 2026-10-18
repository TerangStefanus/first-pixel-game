import test from 'node:test';
import assert from 'node:assert/strict';
import { spawn, spawnSync } from 'node:child_process';
import { mkdtempSync, writeFileSync, readFileSync, existsSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { setTimeout as delay } from 'node:timers/promises';
import { fileURLToPath } from 'node:url';

const wrapper = fileURLToPath(new URL('../command-code.mjs', import.meta.url));
async function fixture(scenario, execute) {
  const dir = mkdtempSync(path.join(tmpdir(), 'wildroot-critic-'));
  const entry = path.join(dir, 'fake.mjs'), capture = path.join(dir, 'capture.json');
  const fixtureSource = `import {writeFileSync,readFileSync} from 'node:fs';
const args=process.argv.slice(2), scenario=${JSON.stringify(scenario)}, capture=${JSON.stringify(capture)};
if(args.includes('status')){console.log(JSON.stringify({authenticated:scenario!=='unauth',version:'test',apiKey:'never-print-this'}));process.exit(scenario==='unauth'?1:0);}
if(args.includes('--list-models')){if(scenario==='models-error'){console.error('upstream failure');process.exit(6);}console.log(scenario==='missing'?'another/model': 'minimaxai/minimax-m3');process.exit(0);}
let input='';for await(const chunk of process.stdin)input+=chunk;
writeFileSync(capture,JSON.stringify({args,input,cwd:process.cwd(),pid:process.pid}));
if(scenario==='timeout'){setInterval(()=>{},1000);}else {console.log('review text');process.exit(scenario==='partial'?8:0);}`;
  writeFileSync(entry, fixtureSource);
  const run = (...args) => spawnSync(process.execPath, [wrapper, ...args, '--entry',entry,'--node-path',process.execPath], {encoding:'utf8',timeout:12000});
  try { await execute({run, capture, dir, entry}); } finally { rmSync(dir,{recursive:true,force:true}); }
}

test('status exposes authentication/version only', () => fixture('ok', ({run}) => {
  const r=run('status');assert.equal(r.status,0);assert.deepEqual(JSON.parse(r.stdout),{authenticated:true,version:'test'});
  assert(!r.stdout.includes('never-print-this'));
}));
test('fresh plan review preserves stdin and mandatory flags, with lowercase model catalog', () => fixture('ok', ({run,capture,dir}) => {
  const prompt=path.join(dir,'question.txt');const question='Review exact file.\nKeep "quotes", `ticks`, $() and Unicode: tanah.\n';writeFileSync(prompt,question);
  const r=run('review','--kind','design','--request-file',prompt);assert.equal(r.status,0,r.stderr);
  const saved=JSON.parse(readFileSync(capture));
  assert(saved.input.startsWith('# Independent Game-Design Critic'));
  assert(saved.input.endsWith(question+'\n'));
  for(const flag of ['--no-auto-update','-p','--skip-onboarding','--no-skills','--no-session'])assert(saved.args.includes(flag));
  assert.equal(saved.args[saved.args.indexOf('--model')+1],'MiniMaxAI/MiniMax-M3');
  assert.equal(saved.args[saved.args.indexOf('--permission-mode')+1],'plan');
  assert.equal(saved.args[saved.args.indexOf('--max-turns')+1],'8');
  assert(!saved.args.some(arg=>['--trust','--yolo','--dangerously-skip-permissions','--continue','--resume'].includes(arg)));
  assert.equal(saved.cwd,path.resolve(path.dirname(wrapper),'..'));
}));
test('unauthenticated review stops before inference', () => fixture('unauth', ({run,capture}) => {
  const r=run('review','--request','Review one exact file');assert.equal(r.status,3);assert(!existsSync(capture));
}));
test('missing required model fails without fallback', () => fixture('missing', ({run,capture}) => {
  const r=run('review','--request','Review one exact file');assert.equal(r.status,1);assert.match(r.stderr,/No fallback/);assert(!existsSync(capture));
}));
test('model-list upstream error propagates without inference', () => fixture('models-error', ({run,capture}) => {
  const r=run('review','--request','Review one exact file');assert.equal(r.status,6);assert.match(r.stderr,/upstream failure/);assert(!existsSync(capture));
}));
test('partial/max-turn result stays a failure and preserves review output', () => fixture('partial', ({run}) => {
  const r=run('review','--request','Review one exact file');assert.equal(r.status,8);assert.match(r.stdout,/review text/);
}));
test('timeout terminates subprocess and returns 124', () => fixture('timeout', ({run}) => {
  const r=run('review','--request','Bounded review','--timeout-seconds','5');assert.equal(r.status,124);assert.match(r.stderr,/exceeded 5s/);
}));
test('rejects ambiguous prompt inputs and invalid limits', () => fixture('ok', ({run,capture}) => {
  for(const args of [['review','--request','x','--request-file','x'],['review','--request','x','--max-turns','31'],['review','--request','x','--timeout-seconds','0']])assert.equal(run(...args).status,1);
  assert(!existsSync(capture));
}));

test('interrupt stops the active child and returns 130', () => fixture('timeout', async ({entry,capture}) => {
  const child=spawn(process.execPath,[wrapper,'review','--request','Bounded review','--entry',entry,'--node-path',process.execPath],{stdio:['ignore','pipe','pipe']});
  const done=new Promise((resolve,reject)=>{child.on('close',code=>resolve(code));child.on('error',reject);});
  try {
    for(let i=0;i<100&&!existsSync(capture);i++)await delay(20);
    assert(existsSync(capture),'review subprocess did not start');
    const {pid}=JSON.parse(readFileSync(capture));child.kill('SIGINT');assert.equal(await done,130);
    assert.throws(()=>process.kill(pid,0),{code:'ESRCH'});
  } finally { if(child.exitCode===null)child.kill('SIGKILL'); }
}));
