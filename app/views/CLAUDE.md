# Views

## Layout

- `layouts/application.html.erb` - Main layout with Tailwind CSS
- `layouts/mailer.html.erb` - Email layout
- `layouts/_footer.html.erb` - Shared footer partial

## Page Views

### Pages
- `pages/home.html.erb` - Landing page with featured case study, technologies, credentials
- `pages/about.html.erb` - About page

### Case Studies
- `case_studies/index.html.erb` - Published case studies listing
- `case_studies/show.html.erb` - Single case study detail

### Capabilities
- `capabilities/ship_faster.html.erb`
- `capabilities/rescue_modernize.html.erb`
- `capabilities/deploy_scale.html.erb`
- `capabilities/integrate_extend.html.erb`
- `capabilities/ai_agents.html.erb`

### Health Checks
- `health_checks/new.html.erb` - Intake form
- `health_checks/create.html.erb` - Turbo Stream response
- `health_checks/_success.html.erb` - Success message partial

### Mailers
- `admin_mailer/new_health_check_submission.html.erb` - Admin notification
- `health_check_mailer/confirmation.html.erb` - User confirmation

## Conventions

- Tailwind CSS 4 for all styling
- Turbo Frames/Streams for dynamic form responses
- Partials prefixed with underscore (`_success.html.erb`)
- Stimulus controllers for interactive behavior (navbar, modal, form validation)
- No inline styles; use Tailwind utility classes
