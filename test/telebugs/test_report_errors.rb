# frozen_string_literal: true

require "test_helper"

class Telebugs::Rails::TestReportErrors < Minitest::Test
  def setup
    @stub = stub_request(:post, Telebugs.config.api_url)
      .to_return(status: 201, body: "{}")

    @broken_app = ->(env) { raise StandardError.new("test error") }
  end

  def teardown
    WebMock.reset!
  end

  def test_error_reporter_reports_errors
    middleware = Telebugs::Rails::ReportErrors.new(@broken_app)

    assert_raises(StandardError, "test error") do
      middleware.call(Rack::MockRequest.new("/"))
    end

    sleep 0.01

    assert_requested @stub
  end
end
