# frozen_string_literal: true

module Betsy
  class ShopListingTranslation
    include Betsy::Model

    attribute :listing_id
    attribute :language
    attribute :title
    attribute :description
    attribute :tags

    def self.create_listing_translation(shop_id, listing_id, language, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/translations/#{language}", options)
    end

    def self.get_listing_translation(shop_id, listing_id, language)
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/translations/#{language}")
    end

    def self.update_listing_translation(shop_id, listing_id, language, options = {})
      make_request(:put, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/translations/#{language}", options)
    end
  end
end
