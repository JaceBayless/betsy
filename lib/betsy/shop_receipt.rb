# frozen_string_literal: true

module Betsy
  class ShopReceipt
    include Betsy::Model

    attribute :receipt_id
    attribute :receipt_type
    attribute :seller_user_id
    attribute :seller_email
    attribute :buyer_user_id
    attribute :buyer_email
    attribute :name
    attribute :first_line
    attribute :second_line
    attribute :city
    attribute :state
    attribute :zip
    attribute :formatted_address
    attribute :country_iso
    attribute :payment_method
    attribute :payment_email
    attribute :message_from_seller
    attribute :message_from_buyer
    attribute :message_from_payment
    attribute :is_paid
    attribute :is_shipped
    attribute :create_timestamp
    attribute :update_timestamp
    attribute :gift_message
    attribute :grandtotal
    attribute :subtotal
    attribute :total_price
    attribute :total_shipping_cost
    attribute :total_tax_cost
    attribute :total_vat_cost
    attribute :discount_amt
    attribute :gift_wrap_price
    attribute :shipments
    attribute :transactions

    def self.get_shop_receipt(shop_id, receipt_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/receipts/#{receipt_id}", options)
    end

    def self.get_shop_receipts(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/receipts", options)
    end

    def self.create_receipt_shipment(shop_id, receipt_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/receipts/#{receipt_id}/tracking", options)
    end
  end
end
