require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "validates name presence" do
    project = Project.new(contact: contacts(:jane))
    assert_not project.valid?
    assert_includes project.errors[:name], "can't be blank"
  end

  test "validates status inclusion" do
    project = projects(:website_redesign)
    project.status = "invalid"
    assert_not project.valid?
  end

  test "generates slug from name" do
    project = Project.create!(name: "New Project", contact: contacts(:jane))
    assert_equal "new-project", project.slug
  end

  test "active scope" do
    assert_includes Project.active, projects(:website_redesign)
    assert_not_includes Project.active, projects(:proposed_project)
  end
end
