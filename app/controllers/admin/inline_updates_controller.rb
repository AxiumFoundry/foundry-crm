class Admin::InlineUpdatesController < Admin::BaseController
  ALLOWED_MODELS = {
    "Credential" => { class: Credential, fields: %w[title organization description] }
  }.freeze

  def update
    config = ALLOWED_MODELS[params[:model]]
    unless config&.dig(:fields)&.include?(params[:field])
      render json: { error: "Invalid model or field" }, status: :unprocessable_entity
      return
    end

    record = config[:class].find(params[:id])
    record.update!(params[:field] => params[:value])

    render json: { value: params[:value] }
  end
end
