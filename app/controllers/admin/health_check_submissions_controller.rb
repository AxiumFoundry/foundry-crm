class Admin::HealthCheckSubmissionsController < Admin::BaseController
  def index
    @pagy, @submissions = pagy(HealthCheckSubmission.order(created_at: :desc))
  end

  def show
    @submission = HealthCheckSubmission.find(params[:id])
  end
end
