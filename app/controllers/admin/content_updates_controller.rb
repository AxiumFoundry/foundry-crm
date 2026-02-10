class Admin::ContentUpdatesController < Admin::BaseController
  def update
    key = params[:key]

    unless SiteSetting::CONTENT_DEFAULTS.key?(key)
      render json: { error: "Invalid content key" }, status: :unprocessable_entity
      return
    end

    setting = SiteSetting.current

    if params[:reset]
      setting.content = (setting.content || {}).except(key)
      setting.save!
      render json: { key: key, value: SiteSetting::CONTENT_DEFAULTS[key] }
    else
      setting.content = (setting.content || {}).merge(key => params[:value])
      setting.save!
      render json: { key: key, value: params[:value] }
    end
  end
end
