# frozen_string_literal: true

module Telebugs
  class Railtie < ::Rails::Railtie
    config.after_initialize do |app|
      # https://guides.rubyonrails.org/error_reporting.html
      if ::Rails.version.to_f >= 7.0
        require "telebugs/rails/error_subscriber"
        ::Rails.error.subscribe(Telebugs::Rails::ErrorSubscriber.new)
      end
    end
  end
end