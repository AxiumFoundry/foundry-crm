class Admin::CrmInquiriesController < Admin::BaseController
  def index
    @pagy, @inquiries = pagy(CrmInquiry.order(created_at: :desc))
  end

  def show
    @inquiry = CrmInquiry.find(params[:id])
  end
end
