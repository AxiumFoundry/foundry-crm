require "test_helper"

class TimeEntryTest < ActiveSupport::TestCase
  test "validates description presence" do
    entry = TimeEntry.new(project: projects(:website_redesign), duration_minutes: 60, date: Date.current)
    assert_not entry.valid?
    assert_includes entry.errors[:description], "can't be blank"
  end

  test "validates duration_minutes positive" do
    entry = TimeEntry.new(project: projects(:website_redesign), description: "Test", duration_minutes: 0, date: Date.current)
    assert_not entry.valid?
  end

  test "hours calculation" do
    entry = time_entries(:design_session)
    assert_equal 2.0, entry.hours
  end

  test "billable scope" do
    assert_includes TimeEntry.billable, time_entries(:design_session)
    assert_not_includes TimeEntry.billable, time_entries(:meeting)
  end

  test "unbilled scope" do
    assert_includes TimeEntry.unbilled, time_entries(:design_session)
  end
end
