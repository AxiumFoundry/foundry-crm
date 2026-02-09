class CreateSiteSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :site_settings do |t|
      t.string :business_name, null: false, default: "Foundry CRM"
      t.string :tagline
      t.string :contact_email
      t.string :contact_phone
      t.string :website_url
      t.string :logo_url
      t.string :timezone, default: "America/New_York"
      t.string :default_currency, default: "USD"
      t.string :invoice_prefix, default: "INV"
      t.integer :invoice_next_number, default: 1001
      t.jsonb :theme, default: {}
      t.jsonb :sections, default: {}
      t.jsonb :business_address, default: {}
      t.jsonb :social_links, default: {}

      t.timestamps
    end
  end
end
