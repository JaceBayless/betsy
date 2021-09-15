# frozen_string_literal: true

module Betsy
  class Review
    include Betsy::Model

    attribute :shop_id
    attribute :listing_id
    attribute :transaction_id
    attribute :buyer_user_id
    attribute :rating
    attribute :review
    attribute :language
    attribute :image_url_fullxfull
    attribute :create_timestamp
    attribute :update_timestamp

    def self.get_reviews_by_shop(shop_id, options = {})
      make_request(:get, "/v3/application/shops/#{shop_id}/reviews", options)
    end
  end
end
