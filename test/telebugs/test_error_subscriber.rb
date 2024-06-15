# frozen_string_literal: true

require "test_helper"

class Telebugs::TestErrorSubscriber < Minitest::Test
  def setup
    @stub = stub_request(:post, Telebugs.config.api_url)
      .to_return(status: 201, body: "{}")
  end

  def teardown
    WebMock.reset!
  end

  def test_error_subscriber_subscribes_to_rails_error
    skip("Rails 7.0 and later only") unless Rails.version.to_f >= 7.0

    stub = stub_request(:post, Telebugs.config.api_url)
      .to_return(status: 201, body: "{}")

    if Rails.version.to_f == 7.0 # rubocop:disable Lint/FloatComparison
      Rails.error.report(RuntimeError.new("test railstie"), handled: true)
    else
      Rails.error.report(RuntimeError.new("test railstie"))
    end

    # Wait for the subscriber to process the error since it's async.
    sleep 0.01

    assert_requested stub
  end
end
