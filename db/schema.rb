# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_08_100010) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vector"

  create_table "case_studies", force: :cascade do |t|
    t.text "challenge_details"
    t.string "challenge_summary"
    t.string "client_name", null: false
    t.datetime "created_at", null: false
    t.boolean "featured", default: false
    t.string "industry"
    t.json "metrics"
    t.integer "position"
    t.boolean "published", default: false
    t.text "results"
    t.string "slug", null: false
    t.text "solution"
    t.string "testimonial_author"
    t.string "testimonial_quote"
    t.string "testimonial_role"
    t.datetime "updated_at", null: false
    t.string "website_url"
    t.index ["featured"], name: "index_case_studies_on_featured"
    t.index ["published"], name: "index_case_studies_on_published"
    t.index ["slug"], name: "index_case_studies_on_slug", unique: true
  end

  create_table "chat_conversations", force: :cascade do |t|
    t.string "contact_email"
    t.bigint "contact_id"
    t.string "contact_name"
    t.datetime "created_at", null: false
    t.datetime "last_activity_at", null: false
    t.string "session_id", null: false
    t.string "status", default: "active", null: false
    t.datetime "updated_at", null: false
    t.boolean "wants_human", default: false
    t.index ["contact_id"], name: "index_chat_conversations_on_contact_id"
    t.index ["last_activity_at"], name: "index_chat_conversations_on_last_activity_at"
    t.index ["session_id"], name: "index_chat_conversations_on_session_id"
    t.index ["status"], name: "index_chat_conversations_on_status"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "chat_conversation_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_conversation_id"], name: "index_chat_messages_on_chat_conversation_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "company_name"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name", null: false
    t.datetime "last_contacted_at"
    t.string "last_name"
    t.text "notes"
    t.string "phone"
    t.string "source"
    t.string "stage", default: "lead", null: false
    t.jsonb "tags", default: []
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "website_url"
    t.index ["email"], name: "index_contacts_on_email"
    t.index ["stage"], name: "index_contacts_on_stage"
  end

  create_table "credentials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "credential_type"
    t.date "date_achieved"
    t.text "description"
    t.boolean "featured", default: false
    t.string "organization"
    t.integer "position"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["credential_type"], name: "index_credentials_on_credential_type"
    t.index ["featured"], name: "index_credentials_on_featured"
  end

  create_table "health_check_submissions", force: :cascade do |t|
    t.string "calendly_link"
    t.string "company_name", null: false
    t.string "company_stage"
    t.bigint "contact_id"
    t.string "contact_name", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.text "internal_notes"
    t.text "main_challenges"
    t.string "phone"
    t.datetime "scheduled_at"
    t.string "status", default: "pending"
    t.integer "team_size"
    t.text "tech_stack"
    t.datetime "updated_at", null: false
    t.string "urgency"
    t.index ["contact_id"], name: "index_health_check_submissions_on_contact_id"
    t.index ["email"], name: "index_health_check_submissions_on_email"
    t.index ["status"], name: "index_health_check_submissions_on_status"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.date "due_date"
    t.text "internal_notes"
    t.date "issued_date"
    t.string "kind", default: "invoice", null: false
    t.text "notes"
    t.string "number", null: false
    t.date "paid_date"
    t.string "payment_method"
    t.bigint "project_id"
    t.string "status", default: "draft", null: false
    t.integer "subtotal_cents", default: 0, null: false
    t.integer "tax_cents", default: 0, null: false
    t.decimal "tax_rate", precision: 5, scale: 2, default: "0.0"
    t.integer "total_cents", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_invoices_on_contact_id"
    t.index ["kind"], name: "index_invoices_on_kind"
    t.index ["number"], name: "index_invoices_on_number", unique: true
    t.index ["project_id"], name: "index_invoices_on_project_id"
    t.index ["status"], name: "index_invoices_on_status"
  end

  create_table "knowledge_documents", force: :cascade do |t|
    t.boolean "active", default: true
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.vector "embedding", limit: 1536
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_knowledge_documents_on_active"
  end

  create_table "line_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.bigint "invoice_id", null: false
    t.integer "position"
    t.decimal "quantity", precision: 10, scale: 2, default: "1.0", null: false
    t.integer "total_cents", null: false
    t.integer "unit_price_cents", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.text "description"
    t.date "due_date"
    t.string "name", null: false
    t.integer "position"
    t.bigint "project_id", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.decimal "budget", precision: 10, scale: 2
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.string "name", null: false
    t.text "notes"
    t.decimal "rate_amount", precision: 10, scale: 2
    t.string "rate_type"
    t.string "slug", null: false
    t.date "start_date"
    t.string "status", default: "proposed", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_projects_on_contact_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
    t.index ["status"], name: "index_projects_on_status"
  end

  create_table "site_settings", force: :cascade do |t|
    t.jsonb "business_address", default: {}
    t.string "business_name", default: "Foundry CRM", null: false
    t.string "contact_email"
    t.string "contact_phone"
    t.jsonb "content", default: {}
    t.datetime "created_at", null: false
    t.string "default_currency", default: "USD"
    t.integer "invoice_next_number", default: 1001
    t.string "invoice_prefix", default: "INV"
    t.string "logo_url"
    t.jsonb "sections", default: {}
    t.jsonb "social_links", default: {}
    t.string "tagline"
    t.jsonb "theme", default: {}
    t.string "timezone", default: "America/New_York"
    t.datetime "updated_at", null: false
    t.string "website_url"
  end

  create_table "technologies", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.boolean "featured", default: false
    t.string "icon_class"
    t.string "name", null: false
    t.integer "proficiency_level"
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_technologies_on_category"
    t.index ["featured"], name: "index_technologies_on_featured"
  end

  create_table "time_entries", force: :cascade do |t|
    t.boolean "billable", default: true
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.string "description", null: false
    t.integer "duration_minutes", null: false
    t.bigint "invoice_id"
    t.bigint "project_id", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_time_entries_on_invoice_id"
    t.index ["project_id"], name: "index_time_entries_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "chat_conversations", "contacts"
  add_foreign_key "chat_messages", "chat_conversations"
  add_foreign_key "health_check_submissions", "contacts"
  add_foreign_key "invoices", "contacts"
  add_foreign_key "invoices", "projects"
  add_foreign_key "line_items", "invoices"
  add_foreign_key "milestones", "projects"
  add_foreign_key "projects", "contacts"
  add_foreign_key "time_entries", "invoices"
  add_foreign_key "time_entries", "projects"
end
