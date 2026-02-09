class AddContentToSiteSettings < ActiveRecord::Migration[8.1]
  def change
    add_column :site_settings, :content, :jsonb, default: {}
  end
end
