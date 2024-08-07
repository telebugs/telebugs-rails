# frozen_string_literal: true

require "rails"
require "telebugs"

require_relative "rails/version"
require_relative "rails/railtie"

require_relative "rails/middleware/reporter_info"
require_relative "rails/report_errors"

module Telebugs
  module Rails
    class Error < StandardError; end
    # Your code goes here...
  end
end
