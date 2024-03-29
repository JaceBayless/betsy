require "rails/generators"
require "rails/generators/migration"

module Betsy
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "This creates all the initial files needed for the Betsy gem"

      source_root File.expand_path("../templates", __FILE__)

      def copy_betsy_model
        model_file = Betsy.account_model.underscore
        template "etsy_account.rb", "app/models/#{model_file}.rb"
      end

      def copy_betsy_migration
        migration_template "create_etsy_accounts.rb", "db/migrate/create_etsy_accounts.rb", migration_version: migration_version
      end

      def copy_betsy_initalizer
        template "betsy.rb", "config/initializers/betsy.rb"
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end

      def self.next_migration_number(path)
        next_migration_number = current_migration_number(path) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end
    end
  end
end
