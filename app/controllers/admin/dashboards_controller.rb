class Admin::DashboardsController < Admin::BaseController
  def show
    @active_projects_count = Project.active.count
    @outstanding_total = Invoice.outstanding.sum(:total_cents) / 100.0
    @revenue_this_month = Invoice.paid
      .where(paid_date: Date.current.beginning_of_month..Date.current.end_of_month)
      .sum(:total_cents) / 100.0
    @new_leads_count = Contact.leads.where(created_at: Date.current.beginning_of_month..).count

    @overdue_invoices = Invoice.outstanding
      .where("due_date < ?", Date.current)
      .includes(:contact)
      .order(due_date: :asc)
      .limit(5)
    @upcoming_milestones = Milestone.upcoming
      .where(due_date: ..1.week.from_now.to_date)
      .includes(project: :contact)
      .limit(5)
    @recent_leads = Contact.leads
      .where(created_at: 7.days.ago..)
      .order(created_at: :desc)
      .limit(5)
  end
end
