# frozen_string_literal: true

require "test_helper"

class Telebugs::Rails::TestReportErrors < Minitest::Test
  def setup
    @stub = stub_request(:post, Telebugs.config.api_url)
      .to_return(status: 201, body: "{}")
  end

  def teardown
    WebMock.reset!
  end

  def test_report_errors_middleware_returns_response
    app = ->(env) { [200, env, "OK"] }
    middleware = Telebugs::Rails::ReportErrors.new(app)

    response = middleware.call(Rack::MockRequest.env_for("/"))
    assert_equal 200, response[0]
  end

  def test_report_errors_middleware_reports_errors
    broken_app = ->(env) { raise StandardError.new("test error") }
    middleware = Telebugs::Rails::ReportErrors.new(broken_app)

    assert_raises(StandardError, "test error") do
      middleware.call(Rack::MockRequest.new("/"))
    end

    sleep 0.01

    assert_requested @stub
  end

  def test_report_errrors_middleware_reports_action_dispatch_exceptions
    app = ->(env) { [200, env, "OK"] }
    middleware = Telebugs::Rails::ReportErrors.new(app)

    response = middleware.call(Rack::MockRequest.env_for(
      "/",
      "action_dispatch.exception" => StandardError.new("test error")
    ))
    sleep 0.01

    assert_equal 200, response[0]
    assert_requested @stub
  end
end
