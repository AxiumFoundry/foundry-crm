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
