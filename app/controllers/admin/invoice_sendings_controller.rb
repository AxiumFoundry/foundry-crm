class Admin::InvoiceSendingsController < Admin::BaseController
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.update!(status: "sent", issued_date: @invoice.issued_date || Date.current)
    redirect_to admin_invoice_path(@invoice), notice: "#{@invoice.kind.capitalize} marked as sent."
  end
end
