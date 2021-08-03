# frozen_string_literal: true

require_relative "betsy/version"

module Betsy
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "betsy/engine" if defined?(Rails)
