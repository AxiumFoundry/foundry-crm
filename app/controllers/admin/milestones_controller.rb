class Admin::MilestonesController < Admin::BaseController
  def create
    @milestone = Milestone.new(milestone_params)

    if @milestone.save
      redirect_to admin_project_path(@milestone.project), notice: "Milestone added."
    else
      redirect_to admin_project_path(@milestone.project), alert: "Could not add milestone."
    end
  end

  def update
    @milestone = Milestone.find(params[:id])

    if @milestone.update(milestone_params)
      redirect_to admin_project_path(@milestone.project), notice: "Milestone updated."
    else
      redirect_to admin_project_path(@milestone.project), alert: "Could not update milestone."
    end
  end

  def destroy
    @milestone = Milestone.find(params[:id])
    project = @milestone.project
    @milestone.destroy
    redirect_to admin_project_path(project), notice: "Milestone removed."
  end

  private

  def milestone_params
    params.require(:milestone).permit(:project_id, :name, :description, :due_date, :position)
  end
end
