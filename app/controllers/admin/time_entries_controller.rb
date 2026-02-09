class Admin::TimeEntriesController < Admin::BaseController
  before_action :set_time_entry, only: [ :edit, :update, :destroy ]

  def index
    scope = TimeEntry.includes(:project).order(date: :desc)
    scope = scope.where(project_id: params[:project_id]) if params[:project_id].present?
    @total_hours = scope.sum(:duration_minutes) / 60.0
    @pagy, @time_entries = pagy(scope)
  end

  def new
    @time_entry = TimeEntry.new(date: Date.current, project_id: params[:project_id])
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)

    if @time_entry.save
      redirect_to admin_time_entries_path(project_id: @time_entry.project_id), notice: "Time entry logged."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @time_entry.update(time_entry_params)
      redirect_to admin_time_entries_path(project_id: @time_entry.project_id), notice: "Time entry updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    project_id = @time_entry.project_id
    @time_entry.destroy
    redirect_to admin_time_entries_path(project_id: project_id), notice: "Time entry deleted."
  end

  private

  def set_time_entry
    @time_entry = TimeEntry.find(params[:id])
  end

  def time_entry_params
    params.require(:time_entry).permit(:project_id, :description, :duration_minutes, :date, :billable)
  end
end
