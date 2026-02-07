# Controllers

## Resources

| Controller | Routes | Purpose |
|---|---|---|
| `PagesController` | `GET /`, `GET /about` | Static marketing pages |
| `CaseStudiesController` | `GET /case_studies`, `GET /case_studies/:slug` | Portfolio case studies (read-only) |
| `HealthChecksController` | `GET /health_checks/new`, `POST /health_checks` | Intake form submission |
| `CapabilitiesController` | `GET /capabilities/*` | Capability detail pages |

## Routes

```ruby
root "pages#home"
resources :case_studies, only: [:index, :show]
resources :health_checks, only: [:new, :create]
get "capabilities/ship-faster" => "capabilities#ship_faster"
get "capabilities/rescue-modernize" => "capabilities#rescue_modernize"
get "capabilities/deploy-scale" => "capabilities#deploy_scale"
get "capabilities/integrate-extend" => "capabilities#integrate_extend"
get "capabilities/ai-agents" => "capabilities#ai_agents"
get "about" => "pages#about"
```

## Controller Details

### PagesController

- `home` - Loads featured case study, featured technologies, featured credentials
- `about` - Static about page

### CaseStudiesController

- `index` - Published, ordered case studies
- `show` - Single case study found by FriendlyId slug

### HealthChecksController

- `new` - Renders health check intake form
- `create` - Creates submission, responds with Turbo Stream on success (replaces form with success partial)

### CapabilitiesController

- All actions are empty (render templates directly): `ship_faster`, `rescue_modernize`, `deploy_scale`, `integrate_extend`, `ai_agents`

## Conventions

- RESTful routing only, no `member`/`collection` blocks
- Turbo Stream responses for form submissions
- Strong params for all user input
- FriendlyId for slug-based lookups on CaseStudy
