class Admin::SiteSettingsController < Admin::BaseController
  def edit
    @site_setting = SiteSetting.current
  end

  def update
    @site_setting = SiteSetting.current

    if @site_setting.update(site_setting_params)
      redirect_to edit_admin_site_setting_path, notice: "Settings updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def site_setting_params
    params.require(:site_setting).permit(
      :business_name, :tagline, :contact_email, :contact_phone,
      :website_url, :logo_url, :timezone, :default_currency,
      :invoice_prefix, :invoice_next_number,
      content: SiteSetting::CONTENT_DEFAULTS.keys
    )
  end
end
