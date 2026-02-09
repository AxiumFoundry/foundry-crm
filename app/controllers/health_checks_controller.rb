class HealthChecksController < ApplicationController
  def new
    @submission = HealthCheckSubmission.new
  end

  def create
    @submission = HealthCheckSubmission.new(submission_params)

    if @submission.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "health_check_form",
            partial: "health_checks/success",
            locals: { submission: @submission }
          )
        end
        format.html { redirect_to root_path, notice: "Health check request received!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def submission_params
    params.require(:health_check_submission).permit(
      :company_name, :contact_name, :email, :phone,
      :company_stage, :team_size, :tech_stack,
      :main_challenges, :urgency
    )
  end
end
