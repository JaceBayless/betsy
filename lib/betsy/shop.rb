# frozen_string_literal: true

module Betsy
  class Shop
    include Betsy::Model

    attribute :shop_id
    attribute :user_id
    attribute :shop_name
    attribute :create_date
    attribute :title
    attribute :announcement
    attribute :currency_code
    attribute :is_vacation
    attribute :vacation_message
    attribute :sale_message
    attribute :digital_sale_message
    attribute :update_date
    attribute :listing_active_count
    attribute :digital_listing_count
    attribute :login_name
    attribute :accepts_custom_requests
    attribute :policy_welcome
    attribute :policy_payment
    attribute :policy_shipping
    attribute :policy_refunds
    attribute :policy_additional
    attribute :policy_seller_info
    attribute :policy_update_date
    attribute :policy_has_private_receipt_info
    attribute :has_unstructured_policies
    attribute :policy_privacy
    attribute :vacation_autoreply
    attribute :url
    attribute :image_url_760x100
    attribute :num_favorers
    attribute :languages
    attribute :icon_url_fullxfull
    attribute :is_using_structured_policies
    attribute :has_onboarded_structured_policies
    attribute :include_dispute_form_link
    attribute :is_direct_checkout_onboarded
    attribute :is_calculated_eligible
    attribute :is_opted_in_to_buyer_promise
    attribute :is_shop_us_based
    attribute :transaction_sold_count
    attribute :shipping_from_country_iso
    attribute :shop_location_country_iso
    attribute :review_count
    attribute :review_average

    def self.get_shop(shop_id)
      make_request(:get, "/v3/application/shops/#{shop_id}")
    end

    def self.update_shop(shop_id, options = {})
      make_request(:put, "/v3/application/shops/#{shop_id}", options)
    end

    def self.get_shop_by_owner_user_id(user_id)
      make_request(:get, "/v3/application/users/#{user_id}/shops")
    end

    def self.find_shops(shop_name, options = {})
      options[:shop_name] = shop_name
      make_request(:get, "/v3/application/shops", options)
    end
  end
end
