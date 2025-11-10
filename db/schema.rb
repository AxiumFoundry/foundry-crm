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

ActiveRecord::Schema[8.2].define(version: 2025_11_10_142506) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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
    t.index ["email"], name: "index_health_check_submissions_on_email"
    t.index ["status"], name: "index_health_check_submissions_on_status"
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
end
