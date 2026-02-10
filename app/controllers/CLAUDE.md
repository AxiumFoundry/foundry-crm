# Controllers

## Public Resources

| Controller | Routes | Purpose |
|---|---|---|
| `PagesController` | `GET /`, `GET /about` | Static marketing pages |
| `CaseStudiesController` | `GET /case_studies`, `GET /case_studies/:slug` | Portfolio case studies (read-only) |
| `HealthChecksController` | `GET /health_checks/new`, `POST /health_checks` | Intake form submission |
| `CapabilitiesController` | `GET /capabilities/*` | Capability detail pages |

## Admin Resources

| Controller | Routes | Purpose |
|---|---|---|
| `Admin::DashboardsController` | `GET /admin` | Admin dashboard |
| `Admin::ContactsController` | Full CRUD | Contact management with stage filtering |
| `Admin::ProjectsController` | Full CRUD | Project management with FriendlyId |
| `Admin::InvoicesController` | Full CRUD | Invoicing with nested line items |
| `Admin::TimeEntriesController` | CRUD (no show) | Time tracking with project filtering |
| `Admin::MilestonesController` | Create, Update, Destroy | Project milestones (nested) |
| `Admin::CaseStudiesController` | Full CRUD | Case study management |
| `Admin::HealthCheckSubmissionsController` | Index, Show | Submission review (read-only) |
| `Admin::ChatConversationsController` | Index, Show | Chat conversation review |
| `Admin::KnowledgeDocumentsController` | CRUD (no show) | Knowledge base management |
| `Admin::InvoicePdfsController` | Show | Invoice PDF generation |
| `Admin::InvoiceSendingsController` | Create | Send invoice emails |
| `Admin::InvoicePaymentsController` | Create | Mark invoices as paid |
| `Admin::MilestoneCompletionsController` | Create, Destroy | Toggle milestone completion |
| `Admin::SiteSettingsController` | Edit, Update | Site-wide settings |

## Controller Details

### Admin::BaseController

- All admin controllers inherit from this
- Includes `Pagy::Method` for pagination
- `before_action :require_authentication`
- Uses `admin` layout

### Admin::ContactsController

- Filter by `params[:stage]`
- Full CRUD with strong params

### Admin::ProjectsController

- FriendlyId slug lookups (`Project.friendly.find`)
- Show action loads milestones and provides new milestone form
- Filter by `params[:status]`

### Admin::InvoicesController

- Nested `line_items_attributes` with `allow_destroy: true`
- Auto-generates invoice number via `Invoice.generate_number`
- Index shows summary totals (outstanding, paid, draft)
- Filter by `params[:kind]` and `params[:status]`

### Admin::TimeEntriesController

- Filter by `params[:project_id]`
- Redirects preserve project_id context

## Conventions

- RESTful routing only, no `member`/`collection` blocks
- Turbo Stream responses for form submissions
- Strong params for all user input
- FriendlyId for slug-based lookups (CaseStudy, Project)
- Pagy for pagination in all admin list views
