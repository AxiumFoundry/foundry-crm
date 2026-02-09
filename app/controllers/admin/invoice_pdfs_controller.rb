class Admin::InvoicePdfsController < Admin::BaseController
  def show
    invoice = Invoice.find(params[:id])
    pdf = InvoicePdf.new(invoice)
    send_data pdf.render,
      filename: "#{invoice.number}.pdf",
      type: "application/pdf",
      disposition: "inline"
  end
end
