class Admin::CaseStudiesController < Admin::BaseController
  before_action :set_case_study, only: [ :show, :edit, :update, :destroy ]

  def index
    @pagy, @case_studies = pagy(CaseStudy.ordered)
  end

  def show
  end

  def new
    @case_study = CaseStudy.new
  end

  def create
    @case_study = CaseStudy.new(case_study_params)

    if @metrics_parse_error
      @case_study.errors.add(:metrics, "must be valid JSON")
      render :new, status: :unprocessable_entity
    elsif @case_study.save
      redirect_to admin_case_studies_path, notice: "Case study created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @case_study.assign_attributes(case_study_params)

    if @metrics_parse_error
      @case_study.errors.add(:metrics, "must be valid JSON")
      render :edit, status: :unprocessable_entity
    elsif @case_study.save
      redirect_to admin_case_studies_path, notice: "Case study updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @case_study.destroy
    redirect_to admin_case_studies_path, notice: "Case study deleted."
  end

  private

  def set_case_study
    @case_study = CaseStudy.friendly.find(params[:id])
  end

  def case_study_params
    permitted = params.require(:case_study).permit(
      :client_name, :industry, :challenge_summary, :challenge_details,
      :solution, :results, :testimonial_quote, :testimonial_author,
      :testimonial_role, :website_url, :position, :featured, :published
    )

    metrics_param = params.dig(:case_study, :metrics)
    if metrics_param.present?
      permitted[:metrics] = JSON.parse(metrics_param)
    else
      permitted[:metrics] = nil
    end

    permitted
  rescue JSON::ParserError
    @metrics_parse_error = true
    permitted
  end
end
