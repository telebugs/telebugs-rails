# frozen_string_literal: true

module Telebugs::Rails
  class ErrorSubscriber
    def report(error, handled:, severity:, context:, source: nil)
      Telebugs.report(error)
    end
  end
end
