# frozen_string_literal: true

require "test_helper"

class Telebugs::Rails::Middleware::TestIgnoreDevEnv < Minitest::Test
  def test_ignore_dev_env_middleware_ignores_development_errors
    middleware = Telebugs::Rails::Middleware::IgnoreDevEnv.new("development")

    report = Telebugs::Report.new(StandardError.new("test error"))
    middleware.call(report)

    assert report.ignored
  end

  def test_ignore_dev_env_middleware_ignores_test_errors
    middleware = Telebugs::Rails::Middleware::IgnoreDevEnv.new("test")

    report = Telebugs::Report.new(StandardError.new("test error"))
    middleware.call(report)

    assert report.ignored
  end

  def test_ignore_dev_env_middleware_does_not_ignore_production_errors
    middleware = Telebugs::Rails::Middleware::IgnoreDevEnv.new("production")

    report = Telebugs::Report.new(StandardError.new("test error"))
    middleware.call(report)

    refute report.ignored
  end
end
