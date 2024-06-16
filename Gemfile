# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "minitest", "~> 5.23"
gem "rake", "~> 13.2"

gem "standard"

if ENV["RAILS_VERSION"]
  gem "rails", "~> #{ENV["RAILS_VERSION"]}"
else
  gem "rails"
end

gem "webmock", "~> 3.23"
