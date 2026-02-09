class Admin::InvoicesController < Admin::BaseController
  before_action :set_invoice, only: [ :show, :edit, :update, :destroy ]

  def index
    scope = Invoice.includes(:contact).order(created_at: :desc)
    scope = scope.where(kind: params[:kind]) if params[:kind].present?
    scope = scope.where(status: params[:status]) if params[:status].present?
    @pagy, @invoices = pagy(scope)

    @outstanding_total = Invoice.outstanding.sum(:total_cents) / 100.0
    @paid_total = Invoice.paid.sum(:total_cents) / 100.0
    @draft_total = Invoice.draft.sum(:total_cents) / 100.0
  end

  def show
  end

  def new
    @invoice = Invoice.new(
      number: Invoice.generate_number,
      kind: params[:kind] || "invoice",
      issued_date: Date.current
    )
    @invoice.line_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to admin_invoice_path(@invoice), notice: "#{@invoice.kind.capitalize} created."
    else
      @invoice.line_items.build if @invoice.line_items.empty?
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @invoice.line_items.build if @invoice.line_items.empty?
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to admin_invoice_path(@invoice), notice: "#{@invoice.kind.capitalize} updated."
    else
      @invoice.line_items.build if @invoice.line_items.empty?
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    kind = @invoice.kind
    @invoice.destroy
    redirect_to admin_invoices_path, notice: "#{kind.capitalize} deleted."
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(
      :contact_id, :project_id, :number, :kind, :status,
      :issued_date, :due_date, :tax_rate, :notes, :internal_notes,
      :payment_method,
      line_items_attributes: [ :id, :description, :quantity, :unit_price_cents, :position, :_destroy ]
    )
  end
end
