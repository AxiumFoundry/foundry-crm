require "test_helper"

class Admin::CaseStudiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    post session_path, params: { email: users(:admin).email, password: "password123" }
    @case_study = case_studies(:one)
  end

  test "requires authentication for index" do
    delete session_path
    get admin_case_studies_path
    assert_redirected_to root_path
  end

  test "requires authentication for new" do
    delete session_path
    get new_admin_case_study_path
    assert_redirected_to root_path
  end

  test "requires authentication for create" do
    delete session_path
    post admin_case_studies_path, params: { case_study: { client_name: "Test" } }
    assert_redirected_to root_path
  end

  test "requires authentication for edit" do
    delete session_path
    get edit_admin_case_study_path(@case_study)
    assert_redirected_to root_path
  end

  test "requires authentication for update" do
    delete session_path
    patch admin_case_study_path(@case_study), params: { case_study: { client_name: "Test" } }
    assert_redirected_to root_path
  end

  test "requires authentication for destroy" do
    delete session_path
    delete admin_case_study_path(@case_study)
    assert_redirected_to root_path
  end

  test "index lists all case studies" do
    get admin_case_studies_path
    assert_response :success
    assert_select "td", text: /Acme Corp/
    assert_select "td", text: /Globex Inc/
  end

  test "show displays case study" do
    get admin_case_study_path(@case_study)
    assert_response :success
    assert_select "h1", text: @case_study.client_name
  end

  test "new renders form" do
    get new_admin_case_study_path
    assert_response :success
    assert_select "form"
  end

  test "create with valid params" do
    assert_difference("CaseStudy.count") do
      post admin_case_studies_path, params: {
        case_study: {
          client_name: "New Client",
          challenge_summary: "A brief summary of the challenge"
        }
      }
    end
    assert_redirected_to admin_case_studies_path
    assert_equal "Case study created.", flash[:notice]

    created = CaseStudy.last
    assert_equal "New Client", created.client_name
    assert_not created.published?
  end

  test "create with invalid params re-renders form" do
    assert_no_difference("CaseStudy.count") do
      post admin_case_studies_path, params: {
        case_study: { client_name: "" }
      }
    end
    assert_response :unprocessable_entity
  end

  test "create with metrics JSON" do
    post admin_case_studies_path, params: {
      case_study: {
        client_name: "Metrics Client",
        challenge_summary: "Testing metrics",
        metrics: '{"Speed": "2x faster", "Cost": "40% less"}'
      }
    }
    assert_redirected_to admin_case_studies_path
    created = CaseStudy.last
    assert_equal({ "Speed" => "2x faster", "Cost" => "40% less" }, created.metrics)
  end

  test "create with invalid metrics JSON shows error" do
    post admin_case_studies_path, params: {
      case_study: {
        client_name: "Bad Metrics",
        challenge_summary: "Testing bad metrics",
        metrics: "not valid json"
      }
    }
    assert_response :unprocessable_entity
  end

  test "edit renders form" do
    get edit_admin_case_study_path(@case_study)
    assert_response :success
    assert_select "form"
  end

  test "update with valid params" do
    patch admin_case_study_path(@case_study), params: {
      case_study: { client_name: "Updated Name" }
    }
    assert_redirected_to admin_case_studies_path
    assert_equal "Case study updated.", flash[:notice]
    assert_equal "Updated Name", @case_study.reload.client_name
  end

  test "update with invalid params re-renders form" do
    patch admin_case_study_path(@case_study), params: {
      case_study: { client_name: "" }
    }
    assert_response :unprocessable_entity
  end

  test "destroy deletes case study" do
    assert_difference("CaseStudy.count", -1) do
      delete admin_case_study_path(@case_study)
    end
    assert_redirected_to admin_case_studies_path
    assert_equal "Case study deleted.", flash[:notice]
  end
end
