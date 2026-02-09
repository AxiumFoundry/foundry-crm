class CreateContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :company_name
      t.string :title
      t.string :stage, null: false, default: "lead"
      t.string :source
      t.string :website_url
      t.text :notes
      t.jsonb :tags, default: []
      t.datetime :last_contacted_at

      t.timestamps
    end

    add_index :contacts, :email
    add_index :contacts, :stage
  end
end
