# frozen_string_literal: true

module Betsy
  class ShopListingProduct
    include Betsy::Model

    attribute :product_id
    attribute :sku
    attribute :is_deleted
    attribute :offerings
    attribute :property_values

    def self.get_listing_product(listing_id, product_id)
      make_request(:get, "/v3/application/listings/#{listing_id}/inventory/products/#{product_id}")
    end
  end
end
