# frozen_string_literal: true

module Betsy
  class ShopListingOffering
    include Betsy::Model

    attribute :offering_id
    attribute :quantity
    attribute :is_enabled
    attribute :is_deleted
    attribute :price

    def self.get_listing_offering(listing_id, product_id, product_offering_id)
      make_request(:get, "/v3/application/listings/#{listing_id}/products/#{product_id}/offerings/#{product_offering_id}")
    end
  end
end
