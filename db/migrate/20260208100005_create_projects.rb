class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :contact, null: false, foreign_key: true
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.string :status, null: false, default: "proposed"
      t.string :rate_type
      t.decimal :rate_amount, precision: 10, scale: 2
      t.decimal :budget, precision: 10, scale: 2
      t.date :start_date
      t.date :end_date
      t.text :notes

      t.timestamps
    end

    add_index :projects, :slug, unique: true
    add_index :projects, :status
  end
end
