module ApplicationHelper
  def site_text(key, editable: true)
    value = current_settings.text(key)

    if editable && logged_in?
      tag.span(value,
        class: "editable-text",
        data: {
          controller: "inline-edit",
          action: "click->inline-edit#edit",
          inline_edit_key_value: key
        })
    else
      value
    end
  end

  def editable_field(record, field)
    value = record.public_send(field)
    return value unless logged_in?

    tag.span(value,
      class: "editable-text",
      data: {
        controller: "inline-edit",
        action: "click->inline-edit#edit",
        inline_edit_model_value: record.class.name,
        inline_edit_record_id_value: record.id,
        inline_edit_field_value: field
      })
  end
end
