class CreateTimeEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :time_entries do |t|
      t.references :project, null: false, foreign_key: true
      t.references :invoice, null: true, foreign_key: true
      t.string :description, null: false
      t.integer :duration_minutes, null: false
      t.date :date, null: false
      t.boolean :billable, default: true

      t.timestamps
    end
  end
end
