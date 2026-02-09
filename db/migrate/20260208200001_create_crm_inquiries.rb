class CreateCrmInquiries < ActiveRecord::Migration[8.1]
  def change
    create_table :crm_inquiries do |t|
      t.string :company_name, null: false
      t.string :contact_name, null: false
      t.string :email, null: false
      t.string :phone
      t.text :message
      t.string :status, null: false, default: "pending"
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
