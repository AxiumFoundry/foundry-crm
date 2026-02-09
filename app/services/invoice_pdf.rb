class InvoicePdf
  include ActionView::Helpers::NumberHelper

  COLORS = {
    black: "000000",
    dark: "333333",
    medium: "666666",
    light: "999999",
    rule: "DDDDDD",
    accent: "2563EB"
  }.freeze

  def initialize(invoice)
    @invoice = invoice
    @contact = invoice.contact
    @document = Prawn::Document.new(page_size: "LETTER", margin: [ 60, 50, 60, 50 ])
    generate
  end

  def render
    @document.render
  end

  private

  def generate
    header
    dates_row
    bill_to
    line_items_table
    totals
    notes
    footer
  end

  def header
    @document.font_size(28) do
      @document.text @invoice.kind.upcase, color: COLORS[:black], style: :bold
    end

    @document.move_down 4

    @document.font_size(10) do
      @document.text SiteSetting.current.business_name, color: COLORS[:medium]
    end

    @document.move_down 4

    @document.font_size(12) do
      @document.text @invoice.number, color: COLORS[:dark]
    end

    @document.move_down 4
    status_text = @invoice.status.capitalize
    @document.font_size(10) do
      @document.text status_text, color: COLORS[:accent], style: :bold
    end

    @document.move_down 20
    @document.stroke_color COLORS[:rule]
    @document.stroke_horizontal_rule
    @document.move_down 20
  end

  def dates_row
    dates = []
    dates << [ "Issued", @invoice.issued_date&.strftime("%B %d, %Y") || "N/A" ]
    dates << [ "Due", @invoice.due_date&.strftime("%B %d, %Y") || "N/A" ]
    dates << [ "Paid", @invoice.paid_date.strftime("%B %d, %Y") ] if @invoice.paid_date.present?

    @document.font_size(9) do
      dates.each_with_index do |(label, value), i|
        @document.text label, color: COLORS[:light], style: :bold
        @document.text value, color: COLORS[:dark]
        @document.move_down 6 unless i == dates.size - 1
      end
    end

    @document.move_down 20
  end

  def bill_to
    @document.font_size(9) do
      @document.text "BILL TO", color: COLORS[:light], style: :bold
    end
    @document.move_down 4
    @document.font_size(10) do
      @document.text @contact.full_name, color: COLORS[:black], style: :bold
      @document.text @contact.company_name, color: COLORS[:dark] if @contact.company_name.present?
      @document.text @contact.email, color: COLORS[:medium] if @contact.email.present?
    end
    @document.move_down 24
  end

  def line_items_table
    items = @invoice.line_items.order(:position).map do |item|
      [
        item.description,
        item.quantity.to_s,
        number_to_currency(item.unit_price),
        number_to_currency(item.total)
      ]
    end

    table_data = [ [ "Description", "Qty", "Unit Price", "Total" ] ] + items

    @document.table(table_data, width: @document.bounds.width, cell_style: { size: 9, padding: [ 8, 10 ] }) do |t|
      t.row(0).font_style = :bold
      t.row(0).text_color = COLORS[:medium]
      t.row(0).borders = [ :bottom ]
      t.row(0).border_color = COLORS[:rule]

      t.rows(1..-1).borders = [ :bottom ]
      t.rows(1..-1).border_color = COLORS[:rule]
      t.rows(1..-1).text_color = COLORS[:dark]

      t.columns(1..3).align = :right
      t.column(0).width = @document.bounds.width * 0.5
    end

    @document.move_down 12
  end

  def totals
    data = [ [ "Subtotal", number_to_currency(@invoice.subtotal) ] ]

    if @invoice.tax_rate.to_f > 0
      data << [ "Tax (#{@invoice.tax_rate}%)", number_to_currency(@invoice.tax) ]
    end

    data << [ "Total", number_to_currency(@invoice.total) ]

    x_offset = @document.bounds.width * 0.6

    @document.bounding_box([ x_offset, @document.cursor ], width: @document.bounds.width * 0.4) do
      @document.table(data, width: @document.bounds.width, cell_style: { size: 10, padding: [ 6, 10 ], borders: [] }) do |t|
        t.columns(0).align = :right
        t.columns(0).text_color = COLORS[:medium]
        t.columns(1).align = :right
        t.columns(1).text_color = COLORS[:dark]

        t.row(-1).font_style = :bold
        t.row(-1).size = 12
        t.row(-1).text_color = COLORS[:black]
      end
    end

    @document.move_down 24
  end

  def notes
    return if @invoice.notes.blank?

    @document.stroke_color COLORS[:rule]
    @document.stroke_horizontal_rule
    @document.move_down 16

    @document.font_size(9) do
      @document.text "NOTES", color: COLORS[:light], style: :bold
    end
    @document.move_down 6
    @document.font_size(9) do
      @document.text @invoice.notes, color: COLORS[:dark]
    end
    @document.move_down 16
  end

  def footer
    return if @invoice.payment_method.blank?

    @document.stroke_color COLORS[:rule]
    @document.stroke_horizontal_rule
    @document.move_down 16

    @document.font_size(9) do
      @document.text "PAYMENT METHOD", color: COLORS[:light], style: :bold
    end
    @document.move_down 4
    @document.font_size(9) do
      @document.text @invoice.payment_method, color: COLORS[:dark]
    end
  end
end
