# frozen_string_literal: true

module Telebugs::Rails::Middleware
  class IgnoreDevelopmentErrors < Telebugs::Middleware
    def initialize(rails_env)
      @rails_env = rails_env.to_s
    end

    def call(report)
      report.ignored = (@rails_env == "development" || @rails_env == "test")
    end

    def weight
      -1000
    end
  end
end
