class PagesController < ApplicationController
  def home
    @featured_case_study = CaseStudy.featured.published.first
    @technologies = Technology.featured.by_category
    @credentials = Credential.featured.ordered
  end

  def about
  end
end
