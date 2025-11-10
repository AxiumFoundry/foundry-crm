# NYC Startup Technical Consultant Website - Rails 8 Project Specification

> **📋 Document Type**: Technical Specification & Implementation Guide
> **🔄 Project Status**: Phase 0 Complete (Initial Setup) - Implementation Pending
> **🛠️ Rails Version**: 8.0 (edge/main branch)
> **💎 Ruby Version**: 3.4.7

## Executive Summary

Build a professional consulting website targeting NYC startups, offering fractional senior developer services. The site emphasizes rapid shipping capabilities, technical expertise, and proven results through case studies.

**Note**: This document provides the complete technical specification for building the application. The Rails 8 project has been initialized with all infrastructure configured (Phase 0 complete), but the business logic, models, controllers, and views are yet to be implemented.

## Project Overview

### Business Goal
Create a compelling online presence that positions the consultant as the go-to solution for NYC startups needing senior technical expertise without the commitment of a full-time hire.

### Value Proposition
"I help NYC startups ship product without hiring senior developers"

### Target Audience
- Early-stage NYC startups (Seed to Series A)
- Non-technical founders needing technical leadership
- Growing startups with junior teams needing senior guidance
- Companies facing technical debt or scaling challenges

## Technical Stack

### Core Technologies
- **Framework**: Rails 8 (edge version from main branch)
- **Database**: PostgreSQL (required for Solid Queue/Cache/Cable)
- **Frontend**: Hotwire/Turbo (Stimulus, Turbo Drive, Turbo Frames, Turbo Streams)
- **CSS**: Tailwind CSS
- **Deployment**: Kamal (Rails 8 default) - also compatible with Railway, Render, or Fly.io
- **Version Control**: Git/GitHub

### Additional Technologies
- **Background Jobs**: Solid Queue (Rails 8 default)
- **Caching**: Solid Cache (Rails 8 default)
- **Cable**: Solid Cable (Rails 8 default)
- **File Storage**: Active Storage with S3 for production
- **Email**: Action Mailer with SendGrid/Postmark
- **Error Tracking**: Honeybadger
- **Analytics**: Plausible or Fathom (privacy-focused)
- **Production Server**: Thruster (Rails 8 default, HTTP/2 proxy for Puma)
- **URL Slugs**: FriendlyId for human-readable URLs

## Prerequisites

Before starting development, ensure you have:
- **Ruby**: 3.4.7 (check with `ruby -v`)
- **PostgreSQL**: 14+ (Rails 8 requires PostgreSQL for Solid Queue/Cache/Cable)
- **Node.js**: 18+ and npm (for JavaScript dependencies)
- **Docker**: Latest version (for Kamal deployment)
- **Git**: For version control

## Getting Started

The Rails 8 application is already initialized. To start implementing the features:

1. **Install dependencies**:
   ```bash
   bundle install
   npm install
   ```

2. **Set up the database**:
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   # After creating migrations
   ```

3. **Add required gems** (see Additional Gems Required section):
   ```bash
   # Add to Gemfile, then:
   bundle install
   ```

4. **Start development server**:
   ```bash
   bin/dev
   # This starts Rails server and watches Tailwind CSS
   ```

5. **Follow Phase 1 implementation plan** to build out the features defined in this specification.

## Additional Gems Required

Add these gems to your Gemfile beyond the Rails 8 defaults:

```ruby
# Gemfile additions
gem "friendly_id", "~> 5.5" # For human-readable URL slugs
gem "honeybadger", "~> 6.1" # Error tracking (already included)
gem "image_processing", "~> 1.2" # For Active Storage variants (already included)

# Optional: Email service provider
# gem "sendgrid-ruby"
# gem "postmark-rails"
```

## Database Schema

```ruby
# db/migrate/001_create_case_studies.rb
class CreateCaseStudies < ActiveRecord::Migration[8.0]
  def change
    create_table :case_studies do |t|
      t.string :client_name, null: false
      t.string :slug, null: false
      t.string :industry
      t.string :challenge_summary
      t.text :challenge_details
      t.text :solution
      t.text :results
      t.json :metrics # Store quantifiable results
      t.string :testimonial_quote
      t.string :testimonial_author
      t.string :testimonial_role
      t.integer :position # For ordering
      t.boolean :featured, default: false
      t.boolean :published, default: false

      t.timestamps
    end

    add_index :case_studies, :slug, unique: true
    add_index :case_studies, :featured
    add_index :case_studies, :published
  end
end

# db/migrate/002_create_health_check_submissions.rb
class CreateHealthCheckSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :health_check_submissions do |t|
      t.string :company_name, null: false
      t.string :contact_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :company_stage # seed, series_a, series_b, etc
      t.integer :team_size
      t.text :tech_stack
      t.text :main_challenges
      t.string :urgency # immediate, this_quarter, exploratory
      t.datetime :scheduled_at
      t.string :calendly_link
      t.string :status, default: 'pending' # pending, scheduled, completed
      t.text :internal_notes

      t.timestamps
    end

    add_index :health_check_submissions, :email
    add_index :health_check_submissions, :status
  end
end

# db/migrate/003_create_technologies.rb
class CreateTechnologies < ActiveRecord::Migration[8.0]
  def change
    create_table :technologies do |t|
      t.string :name, null: false
      t.string :category # frontend, backend, database, devops, etc
      t.string :icon_class # For displaying icons
      t.integer :proficiency_level # 1-5 scale
      t.boolean :featured, default: false

      t.timestamps
    end

    add_index :technologies, :category
    add_index :technologies, :featured
  end
end

# db/migrate/004_create_credentials.rb
class CreateCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :credentials do |t|
      t.string :title, null: false
      t.string :organization
      t.text :description
      t.date :date_achieved
      t.string :credential_type # certification, education, achievement
      t.integer :position # For ordering
      t.boolean :featured, default: false

      t.timestamps
    end

    add_index :credentials, :credential_type
    add_index :credentials, :featured
  end
end
```

## Application Structure

### Models

```ruby
# app/models/case_study.rb
class CaseStudy < ApplicationRecord
  extend FriendlyId
  friendly_id :client_name, use: :slugged

  scope :published, -> { where(published: true) }
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }

  validates :client_name, presence: true
  validates :challenge_summary, presence: true, length: { maximum: 200 }

  def metrics_display
    metrics&.map { |k, v| "#{k}: #{v}" }&.join(", ")
  end
end

# app/models/health_check_submission.rb
class HealthCheckSubmission < ApplicationRecord
  validates :company_name, presence: true
  validates :contact_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :pending, -> { where(status: 'pending') }
  scope :scheduled, -> { where(status: 'scheduled') }

  after_create :send_confirmation_email
  after_create :notify_admin

  private

  def send_confirmation_email
    HealthCheckMailer.confirmation(self).deliver_later
  end

  def notify_admin
    AdminMailer.new_health_check_submission(self).deliver_later
  end
end

# app/models/technology.rb
class Technology < ApplicationRecord
  scope :featured, -> { where(featured: true) }
  scope :by_category, -> { order(:category, :name) }

  validates :name, presence: true, uniqueness: true
  validates :proficiency_level, inclusion: { in: 1..5 }

  def expert?
    proficiency_level >= 4
  end
end

# app/models/credential.rb
class Credential < ApplicationRecord
  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }

  validates :title, presence: true
end
```

### Controllers

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Authentication # if adding admin features
end

# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home
    @featured_case_study = CaseStudy.featured.published.first
    @technologies = Technology.featured.by_category
    @credentials = Credential.featured.ordered
  end
end

# app/controllers/case_studies_controller.rb
class CaseStudiesController < ApplicationController
  def index
    @case_studies = CaseStudy.published.ordered
  end

  def show
    @case_study = CaseStudy.published.friendly.find(params[:id])
  end
end

# app/controllers/health_checks_controller.rb
class HealthChecksController < ApplicationController
  def new
    @submission = HealthCheckSubmission.new
  end

  def create
    @submission = HealthCheckSubmission.new(submission_params)

    if @submission.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "health_check_form",
            partial: "health_checks/success",
            locals: { submission: @submission }
          )
        end
        format.html { redirect_to root_path, notice: "Health check request received!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def submission_params
    params.require(:health_check_submission).permit(
      :company_name, :contact_name, :email, :phone,
      :company_stage, :team_size, :tech_stack,
      :main_challenges, :urgency
    )
  end
end
```

## Views and Frontend

### Layout Structure

```erb
<!-- app/views/layouts/application.html.erb -->
<!DOCTYPE html>
<html lang="en" class="h-full">
  <head>
    <title><%= content_for?(:title) ? yield(:title) : "NYC Startup Technical Consultant" %></title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="description" content="I help NYC startups ship product without hiring senior developers">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>
  </head>

  <body class="h-full">
    <%= render "shared/header" %>

    <main>
      <%= yield %>
    </main>

    <%= render "shared/footer" %>
  </body>
</html>
```

### Home Page Components

```erb
<!-- app/views/pages/home.html.erb -->
<%= turbo_frame_tag "hero" do %>
  <section class="hero-section">
    <div class="container">
      <h1>I help NYC startups ship product without hiring senior developers</h1>
      <p class="tagline">Fractional senior engineering leadership for ambitious startups</p>

      <%= link_to "Get Your Free Technical Health Check",
                  new_health_check_path,
                  class: "cta-button",
                  data: { turbo_frame: "modal" } %>
    </div>
  </section>
<% end %>

<%= turbo_frame_tag "credentials" do %>
  <section class="credentials-section">
    <div class="container">
      <h2>Proven Track Record</h2>
      <div class="credentials-grid">
        <% @credentials.each do |credential| %>
          <div class="credential-card">
            <h3><%= credential.title %></h3>
            <p><%= credential.organization %></p>
            <p><%= credential.description %></p>
          </div>
        <% end %>
      </div>
    </div>
  </section>
<% end %>

<%= turbo_frame_tag "case_study" do %>
  <section class="case-study-section">
    <div class="container">
      <h2>Recent Success: RideMentor</h2>
      <% if @featured_case_study %>
        <div class="case-study-feature">
          <div class="challenge">
            <h3>Challenge</h3>
            <p><%= @featured_case_study.challenge_summary %></p>
          </div>

          <div class="solution">
            <h3>Solution</h3>
            <p><%= @featured_case_study.solution %></p>
          </div>

          <div class="results">
            <h3>Results</h3>
            <p><%= @featured_case_study.results %></p>
            <div class="metrics">
              <%= @featured_case_study.metrics_display %>
            </div>
          </div>

          <% if @featured_case_study.testimonial_quote %>
            <blockquote class="testimonial">
              "<%= @featured_case_study.testimonial_quote %>"
              <cite>
                — <%= @featured_case_study.testimonial_author %>,
                <%= @featured_case_study.testimonial_role %>
              </cite>
            </blockquote>
          <% end %>
        </div>
      <% end %>

      <%= link_to "View All Case Studies", case_studies_path, class: "secondary-link" %>
    </div>
  </section>
<% end %>

<%= turbo_frame_tag "technologies" do %>
  <section class="technologies-section">
    <div class="container">
      <h2>Technical Expertise</h2>
      <div class="tech-categories">
        <% @technologies.group_by(&:category).each do |category, techs| %>
          <div class="tech-category">
            <h3><%= category.humanize %></h3>
            <div class="tech-list">
              <% techs.each do |tech| %>
                <span class="tech-badge" data-proficiency="<%= tech.proficiency_level %>">
                  <%= tech.name %>
                </span>
              <% end %>
            </div>
          </div>
        <% end %>
      </div>
    </div>
  </section>
<% end %>
```

### Health Check Form (Turbo Frame Modal)

```erb
<!-- app/views/health_checks/new.html.erb -->
<%= turbo_frame_tag "modal" do %>
  <div class="modal-backdrop" data-action="click->modal#close">
    <div class="modal-content" data-action="click->modal#stopPropagation">
      <button class="modal-close" data-action="click->modal#close">×</button>

      <h2>NYC Startup Health Check</h2>
      <p>Get a free 30-minute technical audit of your startup's engineering practices</p>

      <%= turbo_frame_tag "health_check_form" do %>
        <%= form_with model: @submission, url: health_checks_path do |f| %>
          <div class="form-group">
            <%= f.label :company_name %>
            <%= f.text_field :company_name, required: true %>
          </div>

          <div class="form-group">
            <%= f.label :contact_name, "Your Name" %>
            <%= f.text_field :contact_name, required: true %>
          </div>

          <div class="form-group">
            <%= f.label :email %>
            <%= f.email_field :email, required: true %>
          </div>

          <div class="form-group">
            <%= f.label :phone, "Phone (Optional)" %>
            <%= f.tel_field :phone %>
          </div>

          <div class="form-group">
            <%= f.label :company_stage %>
            <%= f.select :company_stage,
                options_for_select([
                  ["Pre-seed", "pre_seed"],
                  ["Seed", "seed"],
                  ["Series A", "series_a"],
                  ["Series B+", "series_b_plus"]
                ]),
                prompt: "Select stage" %>
          </div>

          <div class="form-group">
            <%= f.label :team_size, "Current Engineering Team Size" %>
            <%= f.number_field :team_size, min: 0 %>
          </div>

          <div class="form-group">
            <%= f.label :tech_stack, "Current Tech Stack" %>
            <%= f.text_area :tech_stack, rows: 3,
                placeholder: "e.g., React, Node.js, PostgreSQL, AWS" %>
          </div>

          <div class="form-group">
            <%= f.label :main_challenges, "Main Technical Challenges" %>
            <%= f.text_area :main_challenges, rows: 4,
                placeholder: "What technical challenges are you facing?" %>
          </div>

          <div class="form-group">
            <%= f.label :urgency, "Timeline" %>
            <%= f.select :urgency,
                options_for_select([
                  ["Need help immediately", "immediate"],
                  ["This quarter", "this_quarter"],
                  ["Just exploring options", "exploratory"]
                ]),
                prompt: "When do you need help?" %>
          </div>

          <div class="form-actions">
            <%= f.submit "Request Free Health Check", class: "submit-button" %>
          </div>
        <% end %>
      <% end %>
    </div>
  </div>
<% end %>

<!-- app/views/health_checks/_success.html.erb -->
<div class="success-message">
  <h3>Thank you, <%= submission.contact_name %>!</h3>
  <p>I'll review your submission and reach out within 24 hours to schedule your free technical health check.</p>
  <p>Check your email at <%= submission.email %> for confirmation details.</p>
  <%= link_to "Close", root_path, data: { turbo_frame: "_top" }, class: "button" %>
</div>
```

## Stimulus Controllers

```javascript
// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close(event) {
    event.preventDefault()
    this.element.remove()
  }

  stopPropagation(event) {
    event.stopPropagation()
  }
}

// app/javascript/controllers/form_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit"]

  connect() {
    this.validateForm()
  }

  validateForm() {
    const form = this.element
    const submitButton = this.submitTarget

    form.addEventListener("input", () => {
      if (form.checkValidity()) {
        submitButton.disabled = false
        submitButton.classList.remove("disabled")
      } else {
        submitButton.disabled = true
        submitButton.classList.add("disabled")
      }
    })
  }
}

// app/javascript/controllers/analytics_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { event: String, properties: Object }

  track() {
    // Integration with your analytics provider
    if (window.plausible) {
      window.plausible(this.eventValue, { props: this.propertiesValue })
    }
  }
}
```

## Routes Configuration

```ruby
# config/routes.rb
Rails.application.routes.draw do
  root "pages#home"

  resources :case_studies, only: [:index, :show]
  resources :health_checks, only: [:new, :create]

  # Admin routes (if needed)
  namespace :admin do
    resources :case_studies
    resources :health_check_submissions, only: [:index, :show, :update]
    resources :technologies
    resources :credentials
  end

  # Health check endpoint for monitoring
  get "up" => "rails/health#show", as: :rails_health_check
end
```

## Mailer Templates

```erb
<!-- app/views/health_check_mailer/confirmation.html.erb -->
<h2>Thank you for requesting a NYC Startup Health Check!</h2>

<p>Hi <%= @submission.contact_name %>,</p>

<p>I've received your request for a free technical health check for <%= @submission.company_name %>.</p>

<p>Here's what happens next:</p>
<ol>
  <li>I'll review your submission within 24 hours</li>
  <li>You'll receive a calendar link to schedule our 30-minute session</li>
  <li>We'll discuss your technical challenges and identify quick wins</li>
</ol>

<p>Based on what you've shared, I'm particularly interested in discussing your challenges with:</p>
<p><em><%= @submission.main_challenges %></em></p>

<p>Talk soon,<br>
[Your Name]<br>
Senior Technical Consultant</p>

<!-- app/views/admin_mailer/new_health_check_submission.html.erb -->
<h2>New Health Check Submission</h2>

<p><strong>Company:</strong> <%= @submission.company_name %></p>
<p><strong>Contact:</strong> <%= @submission.contact_name %></p>
<p><strong>Email:</strong> <%= @submission.email %></p>
<p><strong>Phone:</strong> <%= @submission.phone || "Not provided" %></p>
<p><strong>Stage:</strong> <%= @submission.company_stage %></p>
<p><strong>Team Size:</strong> <%= @submission.team_size %></p>
<p><strong>Tech Stack:</strong> <%= @submission.tech_stack %></p>
<p><strong>Challenges:</strong> <%= @submission.main_challenges %></p>
<p><strong>Urgency:</strong> <%= @submission.urgency %></p>

<%= link_to "View in Admin", admin_health_check_submission_url(@submission) %>
```

## Deployment Configuration

```ruby
# config/deploy.yml (for Kamal/Rails 8 deployment)
# Name of your application. Used to uniquely configure containers.
service: axium_foundry

# Name of the container image (use your-user/app-name on external registries).
image: axium_foundry

# Deploy to these servers.
servers:
  web:
    - 192.168.0.1
  # job:
  #   hosts:
  #     - 192.168.0.1
  #   cmd: bin/jobs

# Enable SSL auto certification via Let's Encrypt (optional)
# proxy:
#   ssl: true
#   host: app.example.com

# Where you keep your container images.
registry:
  # For production, use hub.docker.com / registry.digitalocean.com / ghcr.io / etc.
  server: localhost:5555  # Development default

  # For production:
  # username: your-username
  # password:
  #   - KAMAL_REGISTRY_PASSWORD

# Inject ENV variables into containers (secrets come from .kamal/secrets).
env:
  secret:
    - RAILS_MASTER_KEY
  clear:
    # Run the Solid Queue Supervisor inside the web server's Puma process to do jobs.
    # When you start using multiple servers, you should split out job processing to a dedicated machine.
    SOLID_QUEUE_IN_PUMA: true

    # Set number of processes dedicated to Solid Queue (default: 1)
    # JOB_CONCURRENCY: 3

    # Set number of cores available to the application on each server (default: 1).
    # WEB_CONCURRENCY: 2

    # Match this to any external database server to configure Active Record correctly
    # DB_HOST: 192.168.0.2

# Aliases for common commands
aliases:
  console: app exec --interactive --reuse "bin/rails console"
  shell: app exec --interactive --reuse "bash"
  logs: app logs -f
  dbc: app exec --interactive --reuse "bin/rails dbconsole --include-password"

# Use a persistent storage volume for Active Storage files.
volumes:
  - "axium_foundry_storage:/rails/storage"

# Bridge fingerprinted assets between versions
asset_path: /rails/public/assets

# Configure the image builder.
builder:
  arch: amd64

# Dockerfile
# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t axium_foundry .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name axium_foundry axium_foundry

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.7
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment variables and enable jemalloc for reduced memory usage and latency.
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY vendor/* ./vendor/
COPY Gemfile Gemfile.lock ./

RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile -j 1 --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile -j 1 app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash
USER 1000:1000

# Copy built artifacts: gems, application
COPY --chown=rails:rails --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --chown=rails:rails --from=build /rails /rails

# Entrypoint prepares the database
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server via Thruster by default, this can be overwritten at runtime
EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]
```

## Testing Strategy

This project uses **Minitest** (Rails 8 default) for testing. For RSpec, add the `rspec-rails` gem.

### System Test Example (Minitest)

```ruby
# test/system/health_check_flow_test.rb
require "application_system_test_case"

class HealthCheckFlowTest < ApplicationSystemTestCase
  test "user requests a health check" do
    visit root_path

    click_link "Get Your Free Technical Health Check"

    within_frame "modal" do
      fill_in "Company name", with: "TestCo"
      fill_in "Your Name", with: "Jane Founder"
      fill_in "Email", with: "jane@testco.com"
      select "Seed", from: "Company stage"
      fill_in "Current Engineering Team Size", with: "3"
      fill_in "Current Tech Stack", with: "React, Node, PostgreSQL"
      fill_in "Main Technical Challenges", with: "Scaling issues"
      select "This quarter", from: "Timeline"

      click_button "Request Free Health Check"

      assert_text "Thank you, Jane Founder!"
    end

    assert_equal "TestCo", HealthCheckSubmission.last.company_name
  end
end
```

### Model Test Example (Minitest)

```ruby
# test/models/case_study_test.rb
require "test_helper"

class CaseStudyTest < ActiveSupport::TestCase
  test "should not save case study without client_name" do
    case_study = CaseStudy.new
    assert_not case_study.save, "Saved case study without client_name"
  end

  test "should save valid case study" do
    case_study = CaseStudy.new(
      client_name: "TestCo",
      challenge_summary: "Needed technical leadership"
    )
    assert case_study.save, "Failed to save valid case study"
  end

  test ".featured returns only featured case studies" do
    featured = case_studies(:featured_one)
    regular = case_studies(:regular_one)

    assert_includes CaseStudy.featured, featured
    assert_not_includes CaseStudy.featured, regular
  end
end
```

### Alternative: RSpec Setup

If you prefer RSpec, add to Gemfile:

```ruby
group :development, :test do
  gem "rspec-rails", "~> 6.1"
  gem "factory_bot_rails"
  gem "faker"
end

group :test do
  gem "shoulda-matchers", "~> 6.0"
end
```

Then run: `rails generate rspec:install`

## SEO and Performance Optimizations

```ruby
# config/initializers/content_security_policy.rb
Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https
    policy.style_src   :self, :https, :unsafe_inline
  end
end

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :set_cache_headers

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "public, max-age=3600"
  end
end

# config/environments/production.rb
Rails.application.configure do
  config.force_ssl = true
  config.ssl_options = { hsts: { subdomains: true, preload: true, expires: 1.year } }

  config.action_controller.perform_caching = true
  config.cache_store = :solid_cache_store

  config.active_job.queue_adapter = :solid_queue
end
```

## Seed Data

```ruby
# db/seeds.rb
# Create sample credentials
Credential.create!([
  {
    title: "10+ Years Senior Engineering Experience",
    organization: "Various NYC Startups",
    description: "Led engineering teams at 5 successful NYC startups from seed to exit",
    credential_type: "experience",
    featured: true,
    position: 1
  },
  {
    title: "Former CTO",
    organization: "TechStartup (Acquired 2023)",
    description: "Built and scaled engineering team from 2 to 25 developers",
    credential_type: "experience",
    featured: true,
    position: 2
  },
  {
    title: "AWS Certified Solutions Architect",
    organization: "Amazon Web Services",
    credential_type: "certification",
    featured: true,
    position: 3
  }
])

# Create RideMentor case study
CaseStudy.create!(
  client_name: "RideMentor",
  industry: "EdTech",
  challenge_summary: "Struggling to ship features with a junior team lacking senior guidance",
  challenge_details: "RideMentor's team of 3 junior developers was taking 3+ months to ship basic features. Technical debt was mounting, deployment was manual and error-prone, and the team lacked architectural direction.",
  solution: "Implemented CI/CD pipeline, established code review processes, created architectural documentation, and provided weekly mentorship sessions to level up the team.",
  results: "Reduced deployment time from 4 hours to 15 minutes. Cut feature delivery time by 70%. Zero production incidents in 6 months.",
  metrics: {
    "Deployment time": "93% reduction",
    "Feature velocity": "3x increase",
    "Production incidents": "100% reduction",
    "Team satisfaction": "Highest ever"
  },
  testimonial_quote: "Having a fractional CTO transformed our engineering team. We're shipping faster than ever and our developers are growing rapidly.",
  testimonial_author: "Sarah Chen",
  testimonial_role: "CEO, RideMentor",
  featured: true,
  published: true,
  position: 1
)

# Create technologies
technologies = [
  # Backend
  { name: "Ruby on Rails", category: "backend", proficiency_level: 5, featured: true },
  { name: "Node.js", category: "backend", proficiency_level: 4, featured: true },
  { name: "Python", category: "backend", proficiency_level: 4, featured: false },
  { name: "Go", category: "backend", proficiency_level: 3, featured: false },

  # Frontend
  { name: "React", category: "frontend", proficiency_level: 4, featured: true },
  { name: "Hotwire/Turbo", category: "frontend", proficiency_level: 5, featured: true },
  { name: "TypeScript", category: "frontend", proficiency_level: 4, featured: true },
  { name: "Vue.js", category: "frontend", proficiency_level: 3, featured: false },

  # Database
  { name: "PostgreSQL", category: "database", proficiency_level: 5, featured: true },
  { name: "Redis", category: "database", proficiency_level: 4, featured: true },
  { name: "MongoDB", category: "database", proficiency_level: 3, featured: false },

  # DevOps
  { name: "AWS", category: "devops", proficiency_level: 4, featured: true },
  { name: "Docker", category: "devops", proficiency_level: 4, featured: true },
  { name: "Kubernetes", category: "devops", proficiency_level: 3, featured: false },
  { name: "CI/CD", category: "devops", proficiency_level: 5, featured: true }
]

technologies.each do |tech|
  Technology.create!(tech)
end

puts "Seed data created successfully!"
```

## Implementation Status

**Current Status**: Phase 0 Complete ✓

This document serves as the **technical specification** for the NYC Startup Technical Consultant website. The Rails 8 application has been initialized, but business logic implementation is pending.

### What's Implemented ✓
- Rails 8 application initialized (edge version from main branch)
- PostgreSQL database configured
- Hotwire/Turbo + Stimulus JavaScript framework
- Tailwind CSS for styling
- Solid Cache, Solid Queue, Solid Cable (Rails 8 defaults)
- Kamal deployment configuration
- Thruster production server
- Honeybadger error tracking
- Docker multi-stage build setup
- Basic test infrastructure (Minitest)

### What's Pending
- Database migrations for all models
- Model implementations (CaseStudy, HealthCheckSubmission, etc.)
- Controllers (Pages, CaseStudies, HealthChecks)
- Views and frontend components
- Mailers for notifications
- Stimulus controllers for interactivity
- Seed data
- System tests
- Admin interface

## Implementation Phases

### Phase 0: Initial Setup ✓ COMPLETE
1. **Setup & Infrastructure**
   - ✓ Initialize Rails 8 app with PostgreSQL
   - ✓ Configure Hotwire/Turbo
   - ✓ Set up Tailwind CSS
   - ✓ Configure Kamal deployment
   - ✓ Set up Honeybadger error tracking
   - ✓ Configure Docker with Thruster

### Phase 1: MVP (Week 1) - PENDING
1. **Database & Models**
   - Create migrations for all models
   - Implement model validations and scopes
   - Add FriendlyId gem and configure slugs
   - Set up seed data

2. **Controllers & Routes**
   - Implement PagesController for home page
   - Create CaseStudiesController (index, show)
   - Create HealthChecksController (new, create)
   - Configure routes with root path

3. **Views & Frontend**
   - Home page with hero, credentials, and CTA
   - Featured case study section
   - Technologies display
   - Health Check form with Turbo Frame modal
   - Stimulus controllers (modal, form, analytics)

4. **Email Integration**
   - Configure Action Mailer
   - Create HealthCheckMailer for confirmations
   - Create AdminMailer for notifications
   - Set up email templates

### Phase 2: Enhancements (Future)
- Additional case studies
- Blog/content section
- Admin dashboard
- Analytics integration
- A/B testing framework
- Newsletter signup
- Calendly integration for scheduling
- Testimonials carousel
- Services detail pages

## Launch Checklist

- [ ] Domain configured with SSL
- [ ] Database backed up
- [ ] Error monitoring active
- [ ] Analytics installed
- [ ] Email deliverability tested
- [ ] Forms tested end-to-end
- [ ] Mobile responsiveness verified
- [ ] Page speed optimized (<3s load time)
- [ ] SEO meta tags configured
- [ ] Social media cards set up
- [ ] Contact form tested
- [ ] Legal pages (Privacy, Terms)
- [ ] 404/500 error pages styled
- [ ] Health check endpoint working
- [ ] Monitoring alerts configured

## Success Metrics

- **Primary KPIs**
  - Health Check form submissions
  - Conversion rate (visitor to submission)
  - Email open rates
  - Meeting bookings

- **Secondary KPIs**
  - Page load speed
  - Bounce rate
  - Time on site
  - Case study engagement

## Content Guidelines

### Tone of Voice
- Professional but approachable
- Direct and action-oriented
- Focused on value and results
- NYC startup ecosystem aware

### Key Messaging
- "Ship faster without hiring"
- "Senior expertise on demand"
- "From idea to production"
- "Battle-tested in NYC startups"

This specification provides everything Claude Code needs to build your Week 1 positioning site using Rails 8 with PostgreSQL and Hotwire/Turbo frontend.
