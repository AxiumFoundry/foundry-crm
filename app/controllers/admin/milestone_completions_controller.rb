class Admin::MilestoneCompletionsController < Admin::BaseController
  def create
    @milestone = Milestone.find(params[:milestone_id])
    @milestone.update!(completed_at: Time.current)
    redirect_to admin_project_path(@milestone.project), notice: "Milestone completed."
  end

  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.update!(completed_at: nil)
    redirect_to admin_project_path(@milestone.project), notice: "Milestone reopened."
  end
end
