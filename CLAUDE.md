# Foundry CRM - Development Guide

## Overview

Foundry CRM is a lightweight CRM built with Ruby on Rails for solo consultants and small agencies.

**Tech Stack:**
- Rails 8.1, PostgreSQL + pgvector, Hotwire, Tailwind CSS 4
- Solid Queue (background jobs), Solid Cache, Solid Cable
- FriendlyId (URL slugs), Honeybadger (error monitoring)
- Minitest (testing)

## Devcontainer Setup

**IMPORTANT**: All commands run inside the devcontainer using docker exec:

```bash
# Template
docker exec -u vscode -w /workspaces/foundry-crm foundry_crm-rails-app-1 bash -ic "<command>"

# Examples
docker exec -u vscode -w /workspaces/foundry-crm foundry_crm-rails-app-1 bash -ic "rails test"
docker exec -u vscode -w /workspaces/foundry-crm foundry_crm-rails-app-1 bash -ic "rails console"
docker exec -u vscode -w /workspaces/foundry-crm foundry_crm-rails-app-1 bash -ic "bundle exec rubocop"
```

**Do NOT** run `bin/rails` or `bundle` directly on host - they will fail.

## Quick Commands

```bash
# Tests
rails test                                    # All tests
rails test test/models/case_study_test.rb     # Specific file

# Server
rails server                                  # http://localhost:3000

# Database
rails db:migrate
rails db:reset

# Debug
rails console
rails routes
tail -f log/development.log
```

## Code Standards

### No Explanatory Comments

Code should be self-documenting. If it needs a comment to explain *what* it does, refactor it.

Comments OK for:
- **Why** decisions (business rules, constraints)
- Public API docs
- TODO/FIXME markers

### No Over-Engineering

- Don't add features not requested
- Don't add error handling for impossible scenarios
- Don't create abstractions for one-time operations
- Minimum complexity for current task

### RESTful Routing Only

**NEVER** use `member do` or `collection do` blocks.

```ruby
# BAD
resources :case_studies do
  member { post :publish }
end

# GOOD - Create resource controller
resources :case_studies, only: [:index, :show]
resources :case_study_publications, only: [:create]
```

See [app/controllers/CLAUDE.md](app/controllers/CLAUDE.md) for patterns.

## Git Workflow

### Pre-commit Hook

```bash
# One-time setup
git config core.hooksPath .githooks
```

**Automatic checks on commit:**
- RuboCop (when Ruby/YAML files changed, lints all files for consistency)
- Full test suite (`bin/rails test --fail-fast`)
- System tests (`bin/rails test:system --fail-fast`)

**What triggers checks:**
- Code files: `.rb`, `.rake`, `.erb`, `.js`, `.jsx`, `.ts`, `.tsx`, `.gemspec`
- Config files: `.yml`, `.yaml`

Skips all checks for documentation-only commits (*.md, *.txt, etc).

**Smart environment detection:**
- Runs directly when committing from inside devcontainer
- Uses `docker exec` when committing from host machine

If checks fail:
```bash
bundle exec rubocop -A  # Auto-fix RuboCop violations
rails test              # Fix failing tests
```

### Workflow

```bash
git checkout -b feature/name
# make changes
git add .
git commit -m "Add feature: description"  # Runs pre-commit checks automatically
git push origin feature/name
```

## Assets

**DO NOT** run `bin/rails assets:precompile` in development.

Assets are served automatically by dev server. Tailwind CSS rebuilds on-the-fly.

## Key Models

- **Contact** - Central CRM entity with pipeline stages (lead, prospect, client, inactive)
- **Project** - Client engagements with FriendlyId slugs and status tracking
- **Invoice** - Invoices and estimates with line items and PDF generation
- **TimeEntry** - Billable time logging against projects
- **Milestone** - Project phase tracking with completion status
- **CrmInquiry** - Lead capture form with auto-contact creation
- **CaseStudy** - Portfolio entries with FriendlyId slugs
- **HealthCheckSubmission** - Intake form submissions with email notifications
- **Technology** - Tech stack showcase items
- **Credential** - Professional credentials and experience

See [app/models/CLAUDE.md](app/models/CLAUDE.md) for details.

## Component Documentation

Load automatically when working in directories:

- **Models** - [app/models/CLAUDE.md](app/models/CLAUDE.md)
- **Controllers** - [app/controllers/CLAUDE.md](app/controllers/CLAUDE.md)
- **Views** - [app/views/CLAUDE.md](app/views/CLAUDE.md)
- **Stimulus** - [app/javascript/controllers/CLAUDE.md](app/javascript/controllers/CLAUDE.md)
- **Helpers** - [app/helpers/CLAUDE.md](app/helpers/CLAUDE.md)
- **Testing** - [test/CLAUDE.md](test/CLAUDE.md)

## Resources

- Rails Guides: https://guides.rubyonrails.org/
- Turbo: https://turbo.hotwired.dev/handbook
- Stimulus: https://stimulus.hotwired.dev/handbook
- Tailwind: https://tailwindcss.com/docs
