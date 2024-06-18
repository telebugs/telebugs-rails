# frozen_string_literal: true

require "test_helper"

class Telebugs::Rails::TestRailtie < Minitest::Test
  def setup
    @stub = stub_request(:post, Telebugs.config.api_url)
      .to_return(status: 201, body: "{}")
  end

  def teardown
    WebMock.reset!
  end

  def test_error_subscriber_subscribes_to_rails_error
    skip("Rails 7.0 and later only") unless Rails.version.to_f >= 7.0

    if Rails.version.to_f == 7.0 # rubocop:disable Lint/FloatComparison
      Rails.error.report(RuntimeError.new("test railstie"), handled: true)
    else
      Rails.error.report(RuntimeError.new("test railstie"))
    end

    # Wait for the subscriber to process the error since it's async.
    sleep 0.01

    assert_requested @stub
  end

  def test_error_subscriber_respects_the_ignore_dev_middleware
    skip("Rails 7.0 and later only") unless Rails.version.to_f >= 7.0

    env = Rails.env
    Rails.env = "development"
    Telebugs.config.middleware.delete Telebugs::Rails::Middleware::IgnoreDevEnv
    Telebugs.config.middleware.use Telebugs::Rails::Middleware::IgnoreDevEnv.new(Rails.env)

    if Rails.version.to_f == 7.0 # rubocop:disable Lint/FloatComparison
      Rails.error.report(RuntimeError.new("test ignore env"), handled: true)
    else
      Rails.error.report(RuntimeError.new("test ignore env"))
    end

    # Wait for the subscriber to process the error since it's async.
    sleep 0.01

    Rails.env = env
    Telebugs.config.middleware.delete Telebugs::Rails::Middleware::IgnoreDevEnv
    Telebugs.config.middleware.use Telebugs::Rails::Middleware::IgnoreDevEnv.new(Rails.env)

    refute_requested @stub
  end

  def test_report_errors_middleware_inserted_after_debug_exceptions
    middlewares = Rails.configuration.middleware.middlewares.map(&:inspect)
    own_idx = middlewares.index("Telebugs::Rails::ReportErrors")

    assert_equal "ActionDispatch::DebugExceptions", middlewares[own_idx - 1]
  end
end
