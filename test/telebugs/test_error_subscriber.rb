# frozen_string_literal: true

require "test_helper"

class Telebugs::Rails::TestErrorSubscriber < Minitest::Test
  def setup
    @stub = stub_request(:post, Telebugs.config.api_url)
      .to_return(status: 201, body: "{}")
  end

  def teardown
    WebMock.reset!
  end

  def test_error_subscriber_subscribes_to_rails_error
    skip "Rails 7.0 and later only" unless Rails.version.to_f >= 7.0

    error_subscriber = Telebugs::Rails::ErrorSubscriber.new
    p = error_subscriber.report(
      RuntimeError.new("test error"),
      handled: true,
      severity: "error",
      context: {foo: "bar"}
    )
    p.wait

    assert_requested @stub
  end
end
