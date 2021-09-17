# frozen_string_literal: true

module Betsy
  class UserAddress
    include Betsy::Model

    attribute :user_address_id
    attribute :user_id
    attribute :name
    attribute :first_line
    attribute :second_line
    attribute :city
    attribute :state
    attribute :zip
    attribute :iso_country_code
    attribute :country_name
    attribute :is_default_shipping_address

    # STILL IN DEVELOPMENT AS OF 9/16/2021
    def self.get_user_address
    end

    def self.get_user_addresses(options = {})
      make_request(:get, "/v3/application/user/addresses", options)
    end
  end
end
