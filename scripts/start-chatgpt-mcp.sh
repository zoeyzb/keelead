#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

npm install
npx prisma generate
npx prisma db push

npm run dev > .keelead-api.log 2>&1 &
API_PID=$!

cleanup() {
  kill "$API_PID" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

echo "Starting KeeLead API on http://127.0.0.1:3000 ..."
for _ in {1..60}; do
  if curl -fsS http://127.0.0.1:3000 >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

echo "KeeLead MCP: http://127.0.0.1:8767/mcp"
echo "API log:     $ROOT/.keelead-api.log"
echo "Keep this terminal open."

exec npx -y supergateway \
  --stdio "npx tsx $ROOT/mcp/server.ts" \
  --outputTransport streamableHttp \
  --port 8767 \
  --streamableHttpPath /mcp
