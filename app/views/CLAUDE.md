# Views

## Layouts

- `layouts/application.html.erb` - Main public layout with Tailwind CSS
- `layouts/admin.html.erb` - Admin layout with sidebar navigation
- `layouts/admin/_sidebar.html.erb` - Admin sidebar partial
- `layouts/mailer.html.erb` - Email layout
- `layouts/_footer.html.erb` - Shared footer partial

## Public Views

### Pages
- `pages/home.html.erb` - Landing page with featured case study, technologies, credentials
- `pages/about.html.erb` - About page

### Case Studies
- `case_studies/index.html.erb` - Published case studies listing
- `case_studies/show.html.erb` - Single case study detail

### Health Checks
- `health_checks/new.html.erb` - Intake form
- `health_checks/create.html.erb` - Turbo Stream response
- `health_checks/_success.html.erb` - Success message partial

### CRM Inquiries
- `crm_inquiries/new.html.erb` - Lead capture form
- `crm_inquiries/create.html.erb` - Turbo Stream response

### Capabilities
- `capabilities/ship_faster.html.erb`
- `capabilities/rescue_modernize.html.erb`
- `capabilities/deploy_scale.html.erb`
- `capabilities/integrate_extend.html.erb`
- `capabilities/ai_agents.html.erb`

### Products
- `products/foundry_crm.html.erb` - CRM product showcase

## Admin Views

### Dashboard
- `admin/dashboards/show.html.erb` - Admin dashboard overview

### Contacts
- `admin/contacts/index.html.erb` - Contacts list with stage filtering
- `admin/contacts/show.html.erb` - Contact detail
- `admin/contacts/new.html.erb` / `edit.html.erb` - Contact forms

### Projects
- `admin/projects/index.html.erb` - Projects list with status filtering
- `admin/projects/show.html.erb` - Project detail with milestones
- `admin/projects/new.html.erb` / `edit.html.erb` - Project forms

### Invoices
- `admin/invoices/index.html.erb` - Invoices list with summary totals
- `admin/invoices/show.html.erb` - Invoice detail
- `admin/invoices/new.html.erb` / `edit.html.erb` - Invoice forms with nested line items
- `admin/invoices/_form.html.erb` - Shared invoice form partial

### Time Entries
- `admin/time_entries/index.html.erb` - Time entries list
- `admin/time_entries/new.html.erb` / `edit.html.erb` - Time entry forms

### Mailers
- `admin_mailer/new_health_check_submission.html.erb` - Admin notification
- `health_check_mailer/confirmation.html.erb` - User confirmation
- `crm_inquiry_mailer/` - CRM inquiry notifications

### Shared
- `admin/shared/` - Reusable admin partials (pagination, etc.)
- `shared/_chat_widget.html.erb` - AI chat widget

## Conventions

- Tailwind CSS 4 for all styling
- Turbo Frames/Streams for dynamic form responses
- Partials prefixed with underscore (`_success.html.erb`)
- Stimulus controllers for interactive behavior (navbar, modal, form validation)
- No inline styles; use Tailwind utility classes
