# frozen_string_literal: true

require "test_helper"

class Telebugs::Rails::TestRailtie < Minitest::Test
  def setup
    @stub = stub_request(:post, Telebugs.config.api_url)
      .to_return(status: 201, body: "{}")
    @env = Rails.env
  end

  def teardown
    Rails.env = @env
    Telebugs.config.middleware.delete Telebugs::Rails::Middleware::IgnoreDevEnvMiddleware
    Telebugs.config.middleware.use Telebugs::Rails::Middleware::IgnoreDevEnvMiddleware.new(Rails.env)

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

    Rails.env = "development"
    Telebugs.config.middleware.delete Telebugs::Rails::Middleware::IgnoreDevEnvMiddleware
    Telebugs.config.middleware.use Telebugs::Rails::Middleware::IgnoreDevEnvMiddleware.new(Rails.env)

    if Rails.version.to_f == 7.0 # rubocop:disable Lint/FloatComparison
      Rails.error.report(RuntimeError.new("test ignore env"), handled: true)
    else
      Rails.error.report(RuntimeError.new("test ignore env"))
    end

    # Wait for the subscriber to process the error since it's async.
    sleep 0.01

    refute_requested @stub
  end
end
