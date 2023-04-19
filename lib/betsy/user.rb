# frozen_string_literal: true

module Betsy
  class User
    include Betsy::Model

    attribute :user_id
    attribute :shop_id
    attribute :primary_email
    attribute :first_name
    attribute :last_name
    attribute :image_url_75x75

    def self.get_user(user_id, options = {})
      make_request(:get, "/v3/application/users/#{user_id}", options)
    end

    def self.get_me(options = {})
      make_request(:get, "/v3/application/users/me", options)
    end
  end
end
