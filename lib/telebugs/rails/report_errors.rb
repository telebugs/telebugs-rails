# frozen_string_literal: true

module Telebugs::Rails
  # Telebugs middleware for Rails. Any errors raised by the upstream application
  # will be delivered to Telebugs and re-raised.
  class ReportErrors
    def initialize(app)
      @app = app
    end

    def call(env)
      dup.call!(env)
    end

    def call!(env)
      response = call_app(env)

      # The exceptions app should be passed as a parameter on initialization of
      # ShowExceptions. Every time there is an exception, ShowExceptions will
      # store the exception in env["action_dispatch.exception"], rewrite the
      # PATH_INFO to the exception status code, and call the Rack app.
      # See: https://api.rubyonrails.org/classes/ActionDispatch/ShowExceptions.html
      return response unless env["action_dispatch.exception"]

      Telebugs.report(env["action_dispatch.exception"])

      response
    end

    private

    def call_app(env)
      @app.call(env)
    rescue Exception => e # rubocop:disable Lint/RescueException
      Telebugs.report(e)
      raise
    end
  end
end
