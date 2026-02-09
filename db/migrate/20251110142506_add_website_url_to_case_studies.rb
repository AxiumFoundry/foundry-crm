class AddWebsiteUrlToCaseStudies < ActiveRecord::Migration[8.1]
  def change
    add_column :case_studies, :website_url, :string
  end
end
