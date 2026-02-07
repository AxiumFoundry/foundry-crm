# Axium Foundry Landing - Development Guide

## Overview

Axium Foundry Landing is a Ruby on Rails marketing and portfolio site for Axium Foundry.

**Tech Stack:**
- Rails 8.1, PostgreSQL, Hotwire, Tailwind CSS 4
- Solid Queue (background jobs), Solid Cache, Solid Cable
- FriendlyId (URL slugs), Honeybadger (error monitoring)
- Minitest (testing)

## Devcontainer Setup

**IMPORTANT**: All commands run inside the devcontainer using docker exec:

```bash
# Template
docker exec -u vscode -w /workspaces/axium-foundry-landing axium_foundry_landing-rails-app-1 bash -ic "<command>"

# Examples
docker exec -u vscode -w /workspaces/axium-foundry-landing axium_foundry_landing-rails-app-1 bash -ic "rails test"
docker exec -u vscode -w /workspaces/axium-foundry-landing axium_foundry_landing-rails-app-1 bash -ic "rails console"
docker exec -u vscode -w /workspaces/axium-foundry-landing axium_foundry_landing-rails-app-1 bash -ic "bundle exec rubocop"
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

```bash
git checkout -b feature/name
# make changes
git add .
git commit -m "Add feature: description"
git push origin feature/name
```

## Assets

**DO NOT** run `bin/rails assets:precompile` in development.

Assets are served automatically by dev server. Tailwind CSS rebuilds on-the-fly.

## Key Models

- **CaseStudy** - Client portfolio entries with FriendlyId slugs
- **HealthCheckSubmission** - Intake form submissions with email notifications
- **Technology** - Tech stack showcase items
- **Credential** - Certifications and qualifications

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
