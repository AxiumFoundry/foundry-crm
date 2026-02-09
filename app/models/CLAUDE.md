# Models

## Overview

| Model | Purpose | Key Fields |
|---|---|---|
| `Contact` | Central CRM entity | `first_name`, `last_name`, `email`, `stage`, `source` |
| `Project` | Client engagements | `name`, `slug`, `status`, `rate_type`, `rate_amount`, `budget` |
| `Invoice` | Billing documents | `number`, `kind`, `status`, `total_cents`, `tax_rate` |
| `LineItem` | Invoice line items | `description`, `quantity`, `unit_price_cents`, `total_cents` |
| `TimeEntry` | Billable time logs | `description`, `duration_minutes`, `date`, `billable` |
| `Milestone` | Project phases | `name`, `due_date`, `completed_at`, `position` |
| `CaseStudy` | Portfolio entries | `client_name`, `slug`, `industry`, `published`, `featured` |
| `HealthCheckSubmission` | Intake form data | `company_name`, `contact_name`, `email`, `status` |
| `Technology` | Tech stack items | `name`, `category`, `proficiency_level`, `featured` |
| `Credential` | Professional credentials | `title`, `credential_type`, `organization`, `featured` |

## Contact

- Stages: `lead`, `prospect`, `client`, `inactive`
- Sources: `health_check`, `chat`, `referral`, `website`, `manual`
- Has many: projects, invoices, health_check_submissions, chat_conversations
- Scopes: `leads`, `prospects`, `clients`, `by_stage`
- `full_name` combines first_name and last_name

## Project

- FriendlyId slug generated from `name`
- Statuses: `proposed`, `active`, `paused`, `completed`, `cancelled`
- Belongs to: contact
- Has many: milestones, time_entries, invoices
- Scopes: `active`, `by_status`

## Invoice

- Kinds: `estimate`, `invoice`
- Statuses: `draft`, `sent`, `viewed`, `paid`, `overdue`, `void`
- Belongs to: contact, project (optional)
- Has many: line_items, time_entries
- Auto-generates number via `Invoice.generate_number` using SiteSetting
- `before_save :recalculate_totals` - auto-computes subtotal, tax, total from line items
- Amounts stored in cents (`subtotal_cents`, `tax_cents`, `total_cents`)
- Scopes: `invoices`, `estimates`, `outstanding`, `paid`, `draft`

## LineItem

- Belongs to: invoice
- `before_validation :calculate_total` - quantity * unit_price_cents
- Amounts in cents (`unit_price_cents`, `total_cents`)

## TimeEntry

- Belongs to: project, invoice (optional)
- Scopes: `billable`, `unbilled`, `for_month`
- `hours` returns duration_minutes / 60.0

## Milestone

- Belongs to: project
- Scopes: `upcoming`, `overdue`, `completed`
- `completed?` checks completed_at presence

## CaseStudy

- FriendlyId slug generated from `client_name`
- Scopes: `published`, `featured`, `ordered` (by position)
- Validations: `client_name` (required), `challenge_summary` (max 200 chars)
- `metrics` is a JSON column for quantifiable results

## HealthCheckSubmission

- Scopes: `pending`, `scheduled`
- Status values: `pending`, `scheduled`, `completed`
- Callbacks:
  - `after_create :send_confirmation_email` (via HealthCheckMailer)
  - `after_create :notify_admin` (via AdminMailer)

## Technology

- Scopes: `featured`, `by_category`
- Validations: `name` (required, unique), `proficiency_level` (1-5)
- `expert?` returns true if proficiency_level >= 4

## Credential

- Scopes: `featured`, `ordered` (by position)
- Validations: `title` (required)

## Conventions

- Scopes for common queries (published, featured, ordered)
- Callbacks for email notifications (after_create only)
- No service objects; business logic lives in models
- Use JSONB for flexible structured data (e.g., metrics)
- Store monetary amounts in cents (integer)
