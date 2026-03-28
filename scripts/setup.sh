#!/usr/bin/env bash
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${GREEN}▶ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠ $1${NC}"; }

# 1. Install all pinned tools
log "Installing tools from .mise.toml..."
mise install

# 2. Create data directories
log "Creating data folders..."
mise run init

# 3. Setup .env
if [ ! -f .env ]; then
  log "Creating .env from .env.example..."
  cp .env.example .env

  echo ""
  warn "Fill in the 3 secrets below (input is hidden):"

  read -rsp "  GEMINI_API_KEY: " gemini_key && echo ""
  read -rsp "  LITELLM_MASTER_KEY: " litellm_key && echo ""
  read -rsp "  JUPYTER_TOKEN: " jupyter_token && echo ""

  # Write plaintext first, then encrypt
  sed -i.bak "s|^GEMINI_API_KEY=.*|GEMINI_API_KEY=${gemini_key}|" .env
  sed -i.bak "s|^LITELLM_MASTER_KEY=.*|LITELLM_MASTER_KEY=${litellm_key}|" .env
  sed -i.bak "s|^JUPYTER_TOKEN=.*|JUPYTER_TOKEN=${jupyter_token}|" .env
  rm -f .env.bak

  # Selectively encrypt only the 3 secrets
  log "Encrypting secrets..."
  mise run encrypt

  log ".env ready — encrypted secrets committed safely."
else
  warn ".env already exists — skipping secret setup. Run 'mise run encrypt' if needed."
fi

# 4. Setup gitignore for .env.keys
log "Ensuring .env.keys is gitignored..."
dotenvx ext gitignore --pattern .env.keys

echo ""
log "✅ Setup complete. Run 'mise run dev' to start all services."
echo ""
echo "  Services:"
echo "    LiteLLM  → http://localhost:4000"
echo "    Ollama   → http://localhost:11434"
echo "    Jupyter  → http://localhost:8888"
