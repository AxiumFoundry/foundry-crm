class CaseStudiesController < ApplicationController
  def index
    @case_studies = CaseStudy.published.ordered
  end

  def show
    @case_study = CaseStudy.published.friendly.find(params[:id])
  end
end
