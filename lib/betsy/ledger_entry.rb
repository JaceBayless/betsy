# frozen_string_literal: true

module Betsy
  class LedgerEntry
    include Betsy::Model

    attribute :entry_id
    attribute :ledger_id
    attribute :sequence_number
    attribute :amount
    attribute :currency
    attribute :description
    attribute :balance
    attribute :create_date

    def self.get_shop_payment_account_ledger_entries(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/payment-account/ledger-entries", options)
    end
  end
end
