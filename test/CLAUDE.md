# Testing Guide

## Structure

```
test/
├── controllers/          # Request/controller tests
│   ├── case_studies_controller_test.rb
│   ├── health_checks_controller_test.rb
│   └── pages_controller_test.rb
├── mailers/              # Mailer tests
│   ├── admin_mailer_test.rb
│   └── health_check_mailer_test.rb
├── models/               # Unit tests
│   ├── case_study_test.rb
│   ├── credential_test.rb
│   ├── health_check_submission_test.rb
│   └── technology_test.rb
├── fixtures/             # Test data
│   ├── case_studies.yml
│   ├── credentials.yml
│   ├── health_check_submissions.yml
│   └── technologies.yml
├── system/               # Browser tests (Capybara + Selenium)
├── helpers/
├── integration/
└── test_helper.rb
```

## Running Tests

```bash
# All tests
rails test

# Specific file
rails test test/models/case_study_test.rb

# Specific test by line number
rails test test/models/case_study_test.rb:10

# System tests
rails test:system
```

## Fixtures

All fixtures must satisfy NOT NULL constraints:
- `case_studies`: requires `client_name`, `slug`
- `credentials`: requires `title`
- `technologies`: requires `name`
- `health_check_submissions`: requires `company_name`, `contact_name`, `email`

## Conventions

- Use fixtures for test data
- Arrange, act, assert pattern
- Test public interfaces, not implementation details
- Mailer tests must pass required arguments (e.g., submission object)
- Controller tests: make requests, assert responses and redirects
- Model tests: validations, scopes, callbacks
