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
