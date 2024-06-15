# frozen_string_literal: true

require "rails"
require "telebugs"

require_relative "rails/version"
require_relative "rails/railtie"

module Telebugs
  module Rails
    class Error < StandardError; end
    # Your code goes here...
  end
end
