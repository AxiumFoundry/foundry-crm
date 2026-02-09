class CreateLineItems < ActiveRecord::Migration[8.1]
  def change
    create_table :line_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :description, null: false
      t.decimal :quantity, precision: 10, scale: 2, null: false, default: 1
      t.integer :unit_price_cents, null: false
      t.integer :total_cents, null: false
      t.integer :position

      t.timestamps
    end
  end
end
