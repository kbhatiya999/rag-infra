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

1. **Initialize**:
   ```bash
   mise run init
   ```

2. **Configure Environment**:
   ```bash
   cp .env.example .env
   # Edit .env and add your secrets (OPENAI_API_KEY, LITELLM_MASTER_KEY, JUPYTER_TOKEN)
   ```

3. **Encrypt Secrets**:
   ```bash
   mise run encrypt
   ```

4. **Start Services**:
   ```bash
   mise run dev
   ```

## Tasks
- `mise run dev`: Start all services via overmind.
- `mise run encrypt`: Encrypt sensitive secrets in `.env`.
- `mise run set KEY=X VALUE=Y`: Add or rotate a secret.
- `mise run secrets-check`: Verify decrypted secrets.
- `mise run rotate`: Rotate encrypted secrets.
- `mise run init`: Create necessary data directories.

## Secret Management
- Encrypted secrets: `OPENAI_API_KEY`, `LITELLM_MASTER_KEY`, `JUPYTER_TOKEN`.
- plaintext config remains readable in `.env`.
- `.env.keys` is gitignored and should be shared out-of-band.
