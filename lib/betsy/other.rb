# frozen_string_literal: true

module Betsy
  class Other
    include Betsy::Model

    attribute :application_id

    def self.ping
      make_request(:get, "/v3/application/openapi-ping")
    end
  end
end
