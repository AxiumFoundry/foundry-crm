require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  class TestJob < ApplicationJob
    def perform(arg)
    end
  end

  test "sets Honeybadger context before performing" do
    captured_context = nil

    Honeybadger.singleton_class.alias_method(:original_context, :context)
    Honeybadger.define_singleton_method(:context) { |ctx| captured_context = ctx }

    TestJob.perform_now("test_arg")

    assert_equal "ApplicationJobTest::TestJob", captured_context[:job_name]
    assert_kind_of String, captured_context[:job_id]
    assert_equal [ "test_arg" ], captured_context[:arguments]
  ensure
    if Honeybadger.singleton_class.method_defined?(:original_context)
      Honeybadger.singleton_class.alias_method(:context, :original_context)
      Honeybadger.singleton_class.remove_method(:original_context)
    end
  end
end
