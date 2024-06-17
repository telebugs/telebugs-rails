# frozen_string_literal: true

module Telebugs::Rails
  class Railtie < ::Rails::Railtie
    # https://guides.rubyonrails.org/error_reporting.html
    initializer "telebugs.error_subscribe" do
      # Error reporting is only available in Rails 7.0 and later.
      next unless ::Rails.version.to_f >= 7.0

      require "telebugs/rails/error_subscriber"
      ::Rails.error.subscribe(Telebugs::Rails::ErrorSubscriber.new)
    end

    initializer "telebugs.configure" do
      Telebugs.configure do |c|
        c.middleware.use Middleware::IgnoreDevEnvMiddleware.new(Rails.env)
      end
    end
  end
end
