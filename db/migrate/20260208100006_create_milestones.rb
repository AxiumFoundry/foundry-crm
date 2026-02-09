class CreateMilestones < ActiveRecord::Migration[8.1]
  def change
    create_table :milestones do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.date :due_date
      t.datetime :completed_at
      t.integer :position

      t.timestamps
    end
  end
end
