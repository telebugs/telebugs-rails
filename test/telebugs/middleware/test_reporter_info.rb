# frozen_string_literal: true

require "test_helper"

class Telebugs::Rails::Middleware::TestReporterInfo < Minitest::Test
  def test_reporter_info_is_attached_to_report
    middleware = Telebugs::Rails::Middleware::ReporterInfo.new

    report = Telebugs::Report.new(StandardError.new("test error"))
    middleware.call(report)

    assert_equal 2, report.data[:reporters].size

    r = report.data[:reporters].last

    assert_equal "telebugs-rails", r[:library][:name]
    assert_equal Telebugs::Rails::VERSION, r[:library][:version]
    assert_equal "Rails", r[:platform][:name]
    assert_equal Rails.version, r[:platform][:version]
  end
end
