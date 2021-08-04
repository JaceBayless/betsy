require "active_record"
require "webmock/rspec"
require "betsy"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.dirname(__FILE__) + "/schema.rb"
require File.dirname(__FILE__) + "/models.rb"

RSpec.configure do |config|
  config.before(:each) {
    Betsy.api_key = "abc123"
    Betsy.redirect_uri_base = "http://www.lvh.me:3000"
  }

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
