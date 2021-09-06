# frozen_string_literal: true

module Betsy
  class ShopListingFile
    include Betsy::Model

    attribute :listing_file_id
    attribute :listing_id
    attribute :rank
    attribute :filename
    attribute :filesize
    attribute :size_bytes
    attribute :filetype
    attribute :create_timestamp

    def self.delete_listing_file(shop_id, listing_id, listing_file_id)
      make_request(:delete, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/files/#{listing_file_id}")
    end

    def self.get_listing_file(shop_id, listing_id, listing_file_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/files/#{listing_file_id}")
    end

    def self.get_all_listing_files(shop_id, listing_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/files")
    end

    def self.upload_listing_file(shop_id, listing_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/files", options)
    end
  end
end
