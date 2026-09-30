# ChatGPT local MCP

KeeLead already contains an MCP server. This branch does **not** replace it.

Changes here:
- add the missing `@modelcontextprotocol/sdk` dependency;
- add a Mac launcher that starts the local SQLite-backed API;
- expose the existing stdio MCP as Streamable HTTP through Supergateway.

## Mac quick start

```bash
git checkout chatgpt-mcp-local
chmod +x scripts/start-chatgpt-mcp.sh
./scripts/start-chatgpt-mcp.sh
```

Local endpoints:

- KeeLead app/API: `http://127.0.0.1:3000`
- MCP: `http://127.0.0.1:8767/mcp`

The repo uses local SQLite by default, so Railway/Supabase/Postgres are not required for this setup.

For ChatGPT web, keep the MCP private on your Mac and expose it through OpenAI Secure MCP Tunnel.
