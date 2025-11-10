class AddWebsiteUrlToCaseStudies < ActiveRecord::Migration[8.2]
  def change
    add_column :case_studies, :website_url, :string
  end
end
