class CrmInquiriesController < ApplicationController
  def new
    @inquiry = CrmInquiry.new
  end

  def create
    @inquiry = CrmInquiry.new(inquiry_params)

    if @inquiry.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "crm_inquiry_form",
            partial: "crm_inquiries/success",
            locals: { inquiry: @inquiry }
          )
        end
        format.html { redirect_to root_path, notice: "CRM inquiry received!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def inquiry_params
    params.require(:crm_inquiry).permit(
      :company_name, :contact_name, :email, :phone, :message
    )
  end
end
