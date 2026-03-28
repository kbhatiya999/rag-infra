# rag-infra

Local development infrastructure for RAG services (LiteLLM, Ollama, Jupyter).

## Toolchain
- **mise**: Single entrypoint for all tasks.
- **overmind**: Process manager for local services.
- **dotenvx**: Secret management and environment variable handling.

## Services
| Service  | Port  | Data Path            |
|----------|-------|----------------------|
| LiteLLM  | 4000  | data/litellm/        |
| Ollama   | 11434 | data/ollama/         |
| Jupyter  | 8888  | data/jupyter/        |

## Getting Started

**The single-command bootstrap:**
```bash
# Fresh machine — nothing installed
curl -fsSL https://mise.run | sh && mise run setup
```

Or if `mise` is already installed, just run:
```bash
mise run setup
```

This ensures `dotenvx` and `overmind` are installed, prompts you for credentials, encrypts them securely into `.env`, and configures the `data` folders.

Once done, simply start the RAG environment:
```bash
mise run dev
```

## Tasks
- `mise run setup`: One-time full setup — installs tools, creates data dirs, encrypts secrets.
- `mise run dev`: Start all services via overmind.
- `mise run encrypt`: Encrypt sensitive secrets in `.env`.
- `mise run set KEY=X VALUE=Y`: Add or rotate a secret.
- `mise run secrets-check`: Verify decrypted secrets.
- `mise run rotate`: Rotate encrypted secrets.
- `mise run init`: Create necessary data directories.

## Secret Management
- Encrypted secrets: `GEMINI_API_KEY`, `LITELLM_MASTER_KEY`, `JUPYTER_TOKEN`.
- plaintext config remains readable in `.env`.
- `.env.keys` is gitignored and should be shared out-of-band.
