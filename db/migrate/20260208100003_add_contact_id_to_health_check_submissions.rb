class AddContactIdToHealthCheckSubmissions < ActiveRecord::Migration[8.1]
  def change
    add_reference :health_check_submissions, :contact, null: true, foreign_key: true
  end
end
