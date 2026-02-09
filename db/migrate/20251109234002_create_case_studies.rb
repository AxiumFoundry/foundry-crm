class CreateCaseStudies < ActiveRecord::Migration[8.0]
  def change
    create_table :case_studies do |t|
      t.string :client_name, null: false
      t.string :slug, null: false
      t.string :industry
      t.string :challenge_summary
      t.text :challenge_details
      t.text :solution
      t.text :results
      t.json :metrics # Store quantifiable results
      t.string :testimonial_quote
      t.string :testimonial_author
      t.string :testimonial_role
      t.integer :position # For ordering
      t.boolean :featured, default: false
      t.boolean :published, default: false

      t.timestamps
    end

    add_index :case_studies, :slug, unique: true
    add_index :case_studies, :featured
    add_index :case_studies, :published
  end
end
