# frozen_string_literal: true

require_relative "lib/betsy/version"

Gem::Specification.new do |spec|
  spec.name = "betsy"
  spec.version = Betsy::VERSION
  spec.authors = ["Jace Bayless"]
  spec.email = ["jacebayless@gmail.com"]

  spec.summary = "A gem for the Etsy API V3"
  spec.description = "This gem allows users to simply interact with the Etsy V3 API."
  spec.homepage = "https://github.com/JaceBayless/betsy"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/JaceBayless/betsy"
  spec.metadata["changelog_uri"] = "https://github.com/JaceBayless/betsy/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("standard", "~> 1.1.7")
  spec.add_development_dependency("rspec", "~> 3.10")
  spec.add_development_dependency("activerecord", "~> 4.0.0")
  spec.add_development_dependency("sqlite3")
  spec.add_development_dependency("webmock", "~> 3.13.0")

  spec.add_dependency("faraday", "1.5.1")

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
