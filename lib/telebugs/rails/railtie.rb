# frozen_string_literal: true

module Telebugs::Rails
  class Railtie < ::Rails::Railtie
    initializer "telebugs.rack_middleware" do |app|
      app.config.middleware.insert_after ActionDispatch::DebugExceptions, Telebugs::Rails::ReportErrors
    end

    # https://guides.rubyonrails.org/error_reporting.html
    initializer "telebugs.error_subscribe" do
      # Error reporting is only available in Rails 7.0 and later.
      next unless ::Rails.version.to_f >= 7.0

      require "telebugs/rails/error_subscriber"
      ::Rails.error.subscribe(Telebugs::Rails::ErrorSubscriber.new)
    end

    initializer "telebugs.configure" do
      Telebugs.configure do |c|
        c.root_directory = Rails.root.to_s
        c.middleware.use Middleware::IgnoreDevEnv.new(Rails.env)
      end
    end

    runner do
      at_exit do
        Telebugs.report($!).wait if $!
      end
    end
  end
end
