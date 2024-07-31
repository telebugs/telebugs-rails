# frozen_string_literal: true

module Telebugs::Rails::Middleware
  class ReporterInfo < Telebugs::BaseMiddleware
    REPORTER = {
      library: {name: "telebugs-rails", version: Telebugs::Rails::VERSION}.freeze,
      platform: {name: "Rails", version: Rails.version}.freeze
    }.freeze

    def call(report)
      report.data[:reporters] << REPORTER
    end
  end
end
