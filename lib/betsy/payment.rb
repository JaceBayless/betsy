# frozen_string_literal: true

module Betsy
  class Payment
    include Betsy::Model

    attribute :payment_id
    attribute :buyer_user_id
    attribute :shop_id
    attribute :receipt_id
    attribute :amount_gross
    attribute :amount_fees
    attribute :amount_net
    attribute :posted_gross
    attribute :posted_fees
    attribute :posted_net
    attribute :adjusted_gross
    attribute :adjusted_fees
    attribute :adjusted_net
    attribute :currency
    attribute :shop_currency
    attribute :buyer_currency
    attribute :shipping_user_id
    attribute :shipping_address_id
    attribute :billing_address_id
    attribute :status
    attribute :shipped_timestamp
    attribute :create_timestamp
    attribute :update_timestamp
    attribute :payment_adjustments

    def self.get_payment_account_ledger_entry_payments(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/payment-account/ledger-entries/payments", options)
    end

    def self.get_shop_payment_by_receipt_id(shop_id, receipt_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/receipts/#{receipt_id}/payments", options)
    end

    def self.get_payments(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/payments", options)
    end
  end
end
