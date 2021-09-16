# frozen_string_literal: true

module Betsy
  class ShopShippingProfile
    include Betsy::Model

    # Shipping Carriers
    attribute :name
    attribute :domestic_classes
    attribute :international_classes

    # Shop Shipping Profile
    attribute :title
    attribute :user_id
    attribute :min_processing_days
    attribute :max_processing_days
    attribute :processing_days_display_label
    attribute :origin_country_iso
    attribute :is_deleted
    attribute :shipping_profile_destinations
    attribute :shipping_profile_upgrades
    attribute :origin_postal_code
    attribute :profile_type

    # Shop Shipping Profile Destination
    attribute :shipping_profile_destination_id
    attribute :origin_country_iso
    attribute :destination_country_iso
    attribute :destination_region
    attribute :primary_cost
    attribute :secondary_cost

    # Shop Shipping Profile Upgrade
    attribute :upgrade_id
    attribute :upgrade_name
    attribute :type
    attribute :rank
    attribute :language
    attribute :price
    attribute :secondary_price

    # Shared
    attribute :shipping_carrier_id
    attribute :shipping_profile_id
    attribute :mail_class
    attribute :min_delivery_days
    attribute :max_delivery_days

    def self.get_shipping_carriers(options = {})
      make_request(:get, "/v3/application/shipping-carriers", options)
    end

    def self.create_shop_shipping_profile(shop_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/shipping-profiles", options)
    end

    def self.get_shop_shipping_profiles(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/shipping-profiles", options)
    end

    def self.delete_shop_shipping_profile(shop_id, shipping_profile_id, options = {})
      make_request(:delete, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}", options)
    end

    def self.get_shop_shipping_profile(shop_id, shipping_profile_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}", options)
    end

    def self.update_shop_shipping_profile(shop_id, shipping_profile_id, options = {})
      make_request(:put, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}", options)
    end

    def self.create_shop_shipping_profile_destination(shop_id, shipping_profile_id, options = {})
      make_request(:post, "/v3/application/shops/1/shipping-profiles/1/destinations", options)
    end

    def self.get_shop_shipping_profile_destinations_by_shipping_profile(shop_id, shipping_profile_id, options = {})
      make_request(:get, "/v3/application/shops/1/shipping-profiles/1/destinations", options)
    end

    def self.delete_shop_shipping_profile_destination(shop_id, shipping_profile_id, shipping_profile_destination_id, options = {})
      make_request(:delete, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}/destinations/#{shipping_profile_destination_id}", options)
    end

    def self.update_shop_shipping_profile_destination(shop_id, shipping_profile_id, shipping_profile_destination_id, options = {})
      make_request(:put, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}/destinations/#{shipping_profile_destination_id}", options)
    end

    def self.create_shop_shipping_profile_upgrade(shop_id, shipping_profile_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}/upgrades", options)
    end

    def self.get_shop_shipping_profile_upgrades(shop_id, shipping_profile_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}/upgrades", options)
    end

    def self.delete_shop_shipping_profile_upgrade(shop_id, shipping_profile_id, upgrade_id, options = {})
      make_request(:delete, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}/upgrades/#{upgrade_id}", options)
    end

    def self.update_shop_shipping_profile_upgrade(shop_id, shipping_profile_id, upgrade_id, options = {})
      make_request(:put, "/v3/application/shops/#{shop_id}/shipping-profiles/#{shipping_profile_id}/upgrades/#{upgrade_id}", options)
    end
  end
end
