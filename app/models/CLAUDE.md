# Models

## Overview

| Model | Purpose | Key Fields |
|---|---|---|
| `CaseStudy` | Client portfolio entries | `client_name`, `slug`, `industry`, `published`, `featured` |
| `HealthCheckSubmission` | Intake form data | `company_name`, `contact_name`, `email`, `status` |
| `Technology` | Tech stack items | `name`, `category`, `proficiency_level`, `featured` |
| `Credential` | Certifications | `title`, `credential_type`, `organization`, `featured` |

## CaseStudy

- FriendlyId slug generated from `client_name`
- Scopes: `published`, `featured`, `ordered` (by position)
- Validations: `client_name` (required), `challenge_summary` (max 200 chars)
- `metrics` is a JSON column for quantifiable results
- `metrics_display` method formats metrics as readable string

## HealthCheckSubmission

- Scopes: `pending`, `scheduled`
- Status values: `pending`, `scheduled`, `completed`
- Callbacks:
  - `after_create :send_confirmation_email` (via HealthCheckMailer)
  - `after_create :notify_admin` (via AdminMailer)
- Email validation on `email` field

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
