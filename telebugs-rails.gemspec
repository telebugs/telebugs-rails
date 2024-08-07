# frozen_string_literal: true

require_relative "lib/telebugs/rails/version"

Gem::Specification.new do |spec|
  spec.name = "telebugs-rails"
  spec.version = Telebugs::Rails::VERSION
  spec.authors = ["Kyrylo Silin"]
  spec.email = ["help@telebugs.com"]

  spec.summary = "Report errors to Telebugs from Rails applications."
  spec.description = <<~DESC
    Telebugs Rails is an integration for Rails applications with Telebugs
    (https://telebugs.com). Telebugs is a simple error monitoring tool for
    developers. With Telebugs, you can track production errors in real-time and
    report them to Telegram.
  DESC
  spec.homepage = "https://telebugs.com"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/telebugs/telebugs-rails"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "telebugs", "~> 0.10"
  spec.add_dependency "railties", ">= 6.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
