# frozen_string_literal: true

module Betsy
  class ShopListingInventory
    include Betsy::Model

    attribute :products
    attribute :price_on_property
    attribute :quantity_on_property
    attribute :sku_on_property
    attribute :listing

    def self.get_listing_inventory(listing_id, options = {})
      make_request(:get, "/v3/application/listings/#{listing_id}/inventory", options)
    end

    def self.update_listing_inventory(listing_id, options = {})
      make_request(:put, "/v3/application/listings/#{listing_id}/inventory", options)
    end
  end
end
