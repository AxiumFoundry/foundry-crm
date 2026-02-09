class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :project, null: true, foreign_key: true
      t.string :number, null: false
      t.string :kind, null: false, default: "invoice"
      t.string :status, null: false, default: "draft"
      t.date :issued_date
      t.date :due_date
      t.date :paid_date
      t.integer :subtotal_cents, null: false, default: 0
      t.decimal :tax_rate, precision: 5, scale: 2, default: 0
      t.integer :tax_cents, null: false, default: 0
      t.integer :total_cents, null: false, default: 0
      t.text :notes
      t.text :internal_notes
      t.string :payment_method

      t.timestamps
    end

    add_index :invoices, :number, unique: true
    add_index :invoices, :status
    add_index :invoices, :kind
  end
end
