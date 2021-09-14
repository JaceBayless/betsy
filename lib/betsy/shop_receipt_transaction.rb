# frozen_string_literal: true

module Betsy
  class ShopReceiptTransaction
    include Betsy::Model

    attribute :transaction_id
    attribute :title
    attribute :description
    attribute :seller_user_id
    attribute :buyer_user_id
    attribute :create_timestamp
    attribute :paid_timestamp
    attribute :shipped_timestamp
    attribute :quantity
    attribute :listing_image_id
    attribute :receipt_id
    attribute :is_digital
    attribute :file_data
    attribute :listing_id
    attribute :transaction_type
    attribute :product_id
    attribute :price
    attribute :shipping_cost
    attribute :variations

    def self.get_shop_receipt_transactions_by_listing(shop_id, listing_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/listings/#{listing_id}/transactions", options)
    end
    
    def self.get_shop_receipt_transactions_by_receipt(shop_id, receipt_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/receipts/#{receipt_id}/transactions", options)
    end
    
    def self.get_shop_receipt_transaction(shop_id, transaction_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/transactions/#{transaction_id}", options)
    end

    def self.get_shop_receipt_transactions_by_shop(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/transactions", options)
    end
  end
end
