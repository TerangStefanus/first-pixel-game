#!/bin/bash
set -euo pipefail
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
node_bin="${COMMAND_CODE_NODE:-}"
local_paths="$script_dir/local/paths.json"
if [[ -z "$node_bin" && -f "$local_paths" && "$(uname -s)" == Darwin ]]; then
  node_bin="$(/usr/bin/plutil -extract NodePath raw -o - "$local_paths" 2>/dev/null || true)"
fi
if [[ -z "$node_bin" ]]; then node_bin="$(command -v node || true)"; fi
if [[ -z "$node_bin" || ! -x "$node_bin" ]]; then
  echo 'Node 22+ not found. Configure ignored tools/local/paths.json NodePath, or set COMMAND_CODE_NODE.' >&2
  exit 1
fi
exec "$node_bin" "$script_dir/command-code.mjs" "$@"
