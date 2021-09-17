# frozen_string_literal: true

module Betsy
  class ShopSection
    include Betsy::Model

    attribute :shop_section_id
    attribute :title
    attribute :rank
    attribute :user_id
    attribute :active_listing_count

    def self.create_shop_section(shop_id, options = {})
      make_request(:post, "/v3/application/shops/#{shop_id}/sections", options)
    end

    def self.get_shop_sections(shop_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/sections")
    end

    def self.get_shop_section(shop_id, shop_section_id)
      make_request(:get, "/v3/application/shops/#{shop_id}/sections/#{shop_section_id}")
    end
  end
end
