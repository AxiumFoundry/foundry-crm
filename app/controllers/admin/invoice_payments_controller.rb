class Admin::InvoicePaymentsController < Admin::BaseController
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.update!(status: "paid", paid_date: Date.current)
    redirect_to admin_invoice_path(@invoice), notice: "Invoice marked as paid."
  end
end
