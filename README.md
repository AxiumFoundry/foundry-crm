# Axium Foundry Landing

Marketing and portfolio site for [Axium Foundry](https://axiumfoundry.com).

## Tech Stack

- Ruby 4.0.1, Rails 8.1
- PostgreSQL with pgvector
- Hotwire (Turbo + Stimulus), Tailwind CSS 4
- Solid Queue, Solid Cache, Solid Cable
- Kamal for deployment

## Development Setup

This project uses a **VS Code devcontainer**. To get started:

1. Clone the repo
2. Open in VS Code — it will prompt to reopen in the devcontainer
3. The `postCreateCommand` runs `bin/setup` automatically

Once inside the devcontainer:

```bash
bin/rails server    # http://localhost:3000
bin/rails test      # Run tests
bin/rails console   # Rails console
```

### Running Commands from the Host

If you need to run commands from outside the devcontainer:

```bash
docker exec -u vscode -w /workspaces/axium-foundry-landing \
  axium_foundry_landing-rails-app-1 bash -ic "rails test"
```

## Deployment

Deployed via [Kamal](https://kamal-deploy.org) to a Hetzner VPS.

```bash
kamal deploy       # Full deploy
kamal app logs -f  # Tail logs
kamal console      # Remote Rails console
```

## Pre-commit Hooks

Enable the pre-commit hook for automated RuboCop and test checks:

```bash
git config core.hooksPath .githooks
```
