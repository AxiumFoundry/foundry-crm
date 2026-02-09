require "test_helper"

class SiteSettingTest < ActiveSupport::TestCase
  test "current returns existing record" do
    setting = site_settings(:default)
    assert_equal setting, SiteSetting.current
  end

  test "current creates record if none exists" do
    SiteSetting.delete_all
    assert_difference "SiteSetting.count", 1 do
      SiteSetting.current
    end
  end

  test "validates business_name presence" do
    setting = SiteSetting.new(business_name: nil)
    assert_not setting.valid?
    assert_includes setting.errors[:business_name], "can't be blank"
  end
end
