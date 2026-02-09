require "test_helper"

class MilestoneTest < ActiveSupport::TestCase
  test "validates name presence" do
    milestone = Milestone.new(project: projects(:website_redesign))
    assert_not milestone.valid?
    assert_includes milestone.errors[:name], "can't be blank"
  end

  test "completed?" do
    assert milestones(:completed_milestone).completed?
    assert_not milestones(:design_phase).completed?
  end

  test "completed scope" do
    assert_includes Milestone.completed, milestones(:completed_milestone)
    assert_not_includes Milestone.completed, milestones(:design_phase)
  end
end
