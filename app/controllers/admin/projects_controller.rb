class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]

  def index
    scope = Project.includes(:contact).order(created_at: :desc)
    scope = scope.by_status(params[:status]) if params[:status].present?
    @pagy, @projects = pagy(scope)
  end

  def show
    @milestones = @project.milestones.order(position: :asc)
    @milestone = Milestone.new
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to admin_project_path(@project), notice: "Project created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to admin_project_path(@project), notice: "Project updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_path, notice: "Project deleted."
  end

  private

  def set_project
    @project = Project.friendly.find(params[:id])
  end

  def project_params
    params.require(:project).permit(
      :contact_id, :name, :description, :status, :rate_type,
      :rate_amount, :budget, :start_date, :end_date, :notes
    )
  end
end
