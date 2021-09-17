# frozen_string_literal: true

module Betsy
  class ShopProductionPartner
    include Betsy::Model

    attribute :production_partner_id
    attribute :partner_name
    attribute :location

    def self.get_shop_production_partners(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/production-partners", options)
    end
  end
end
