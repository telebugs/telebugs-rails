# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "telebugs/rails"

require "minitest/autorun"
require "webmock/minitest"

puts "Rails/#{Rails.version}"

ENV["RAILS_ENV"] = "test"

class TestApp < Rails::Application
  config.eager_load = false
end

TestApp.initialize!
