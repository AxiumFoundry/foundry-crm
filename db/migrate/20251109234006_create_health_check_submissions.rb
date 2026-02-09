class CreateHealthCheckSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :health_check_submissions do |t|
      t.string :company_name, null: false
      t.string :contact_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :company_stage # seed, series_a, series_b, etc
      t.integer :team_size
      t.text :tech_stack
      t.text :main_challenges
      t.string :urgency # immediate, this_quarter, exploratory
      t.datetime :scheduled_at
      t.string :calendly_link
      t.string :status, default: 'pending' # pending, scheduled, completed
      t.text :internal_notes

      t.timestamps
    end

    add_index :health_check_submissions, :email
    add_index :health_check_submissions, :status
  end
end
