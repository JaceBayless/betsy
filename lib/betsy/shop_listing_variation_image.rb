# frozen_string_literal: true

module Betsy
  class ShopListingVariationImage
    include Betsy::Model

    attribute :property_id
    attribute :value_id
    attribute :image_id

    def self.get_listing_variation_images(shop_id, listing_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/variation-images")
    end

    def self.update_variation_images(shop_id, listing_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/variation-images", options)
    end
  end
end
