# frozen_string_literal: true

class TelebugsGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/telebugs.rb", <<~RUBY
      # frozen_string_literal: true
      #
      # Telebugs error monitoring.
      #
      # Rails integration guide:
      # https://telebugs.com/docs/integrations/rails
      #
      # Telebugs library guide:
      # https://telebugs.com/docs/integrations/ruby

      Telebugs.configure do |c|
        c.api_key = ENV["TELEBUGS_API_KEY"] || Rails.application.credentials.telebugs_api_key
      end
    RUBY
  end
end
