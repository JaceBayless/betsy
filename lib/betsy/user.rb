# frozen_string_literal: true

module Betsy
  class User
    include Betsy::Model

    attribute :user_id
    attribute :login_name
    attribute :primary_email
    attribute :first_name
    attribute :last_name
    attribute :create_timestamp
    attribute :referred_by_user_id
    attribute :use_new_inventory_endpoints
    attribute :is_seller
    attribute :bio
    attribute :gender
    attribute :birth_month
    attribute :birth_day
    attribute :transaction_buy_count
    attribute :transaction_sold_count

    def self.get_user(user_id, options = {})
      make_request(:get, "/v3/application/users/#{user_id}", options)
    end
  end
end
