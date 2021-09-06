# frozen_string_literal: true

module Betsy
  class ShopListing
    include Betsy::Model

    # listing
    attribute :listing_id
    attribute :user_id
    attribute :shop_id
    attribute :title
    attribute :description
    attribute :state
    attribute :creation_timestamp
    attribute :ending_timestamp
    attribute :original_creation_timestamp
    attribute :last_modified_timestamp
    attribute :state_timestamp
    attribute :quantity
    attribute :shop_section_id
    attribute :featured_rank
    attribute :url
    attribute :num_favorers
    attribute :non_taxable
    attribute :is_customizable
    attribute :is_personalizable
    attribute :personalization_is_required
    attribute :personalization_char_count_max
    attribute :personalization_instructions
    attribute :listing_type
    attribute :tags
    attribute :materials
    attribute :shipping_profile_id
    attribute :processing_min
    attribute :processing_max
    attribute :who_made
    attribute :when_made
    attribute :is_supply
    attribute :item_weight
    attribute :item_weight_unit
    attribute :item_length
    attribute :item_width
    attribute :item_height
    attribute :item_dimensions_unit
    attribute :is_private
    attribute :recipient
    attribute :occasion
    attribute :style
    attribute :file_data
    attribute :has_variations
    attribute :should_auto_renew
    attribute :language
    attribute :price
    attribute :taxonomy_id

    # listing properties
    attribute :property_id
    attribute :property_name
    attribute :scale_id
    attribute :scale_name
    attribute :value_ids
    attribute :values

    def self.create_draft_listing(shop_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/listings", options)
    end

    def self.get_listings_by_shop(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/listings", options)
    end

    def self.delete_listing(listing_id)
      make_request(:delete, "/v3/application/listings/#{listing_id}")
    end

    def self.get_listing(listing_id, options = {})
      make_request(:get, "/v3/application/listings/#{listing_id}", options)
    end

    def self.find_all_listings_active(options = {})
      make_request(:get, "/v3/application/listings/active", options)
    end

    def self.find_all_active_listings_by_shop(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/active", options)
    end

    def self.get_listings_by_listing_ids(options = {})
      make_request(:get, "/v3/application/listings/batch", options)
    end

    def self.get_featured_listings_by_shop(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/featured", options)
    end

    def self.delete_listing_property(shop_id, listing_id, property_id)
      make_request(:delete, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/properties/#{property_id}")
    end

    def self.update_listing_property(shop_id, listing_id, property_id, options = {})
      make_request(:put, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/properties/#{property_id}", options)
    end

    # STILL IN DEVELOPMENT AS OF 8/28/2021
    def self.get_listing_property
    end

    def self.get_listing_properties(shop_id, listing_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/properties")
    end

    def self.update_listing(shop_id, listing_id, options = {})
      make_request(:put, "/v3/application/shops/#{shop_id}/listings/#{listing_id}", options)
    end

    def self.get_listings_by_shop_receipt(shop_id, receipt_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/receipts/#{receipt_id}/listings", options)
    end

    def self.get_listings_by_shop_section_id(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/shop-sections/listings", options)
    end
  end
end
