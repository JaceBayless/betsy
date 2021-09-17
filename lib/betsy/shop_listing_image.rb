# frozen_string_literal: true

module Betsy
  class ShopListingImage
    include Betsy::Model

    attribute :listing_id
    attribute :listing_image_id
    attribute :hex_code
    attribute :red
    attribute :green
    attribute :blue
    attribute :hue
    attribute :saturation
    attribute :brightness
    attribute :is_black_and_white
    attribute :creation_tsz
    attribute :rank
    attribute :url_75x75
    attribute :url_170x135
    attribute :url_570xN
    attribute :url_fullxfull
    attribute :full_height
    attribute :full_width

    def self.delete_listing_image(shop_id, listing_id, listing_image_id, options = {})
      make_request(:delete, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/images/#{listing_image_id}", options)
    end

    def self.get_listing_image(shop_id, listing_id, listing_image_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/images/#{listing_image_id}")
    end

    def self.get_listing_images(shop_id, listing_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/images")
    end

    def self.upload_listing_image(shop_id, listing_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/images", options)
    end
  end
end
