# frozen_string_literal: true

require "active_support"
require "faraday"

require_relative "betsy/version"
require_relative "betsy/model"

module Betsy
  class Error < StandardError; end

  mattr_accessor :api_key
  mattr_accessor :redirect_uri_base

  ALL_SCOPES = ["address_r",
    "address_w",
    "billing_r",
    "cart_r",
    "cart_w",
    "email_r",
    "favorites_r",
    "favorites_w",
    "feedback_r",
    "listings_d",
    "listings_r",
    "listings_w",
    "profile_r",
    "profile_w",
    "recommend_r",
    "recommend_w",
    "shops_r",
    "shops_w",
    "transactions_r",
    "transactions_w"]

  CODE_CHALLENGE_CHARACTERS = ("A".."Z").to_a + ("a".."z").to_a + ("0".."9").to_a + [".", "_", "~", "-"]

  def self.authorization_url(scope: ALL_SCOPES)
    if api_key.nil? && redirect_uri_base.nil?
      raise "Betsy.api_key and Betsy.redirect_uri_base must be set"
    elsif api_key.nil?
      raise "Betsy.api_key must be set"
    elsif redirect_uri_base.nil?
      raise "Betsy.redirect_uri_base must be set"
    end

    redirect_uri = "#{redirect_uri_base}/etsy_response_listener"
    scope = scope.join("%20")
    state = generate_state
    code_verifier = generate_code_verifier
    code_challenge = Digest::SHA256.base64digest(code_verifier).tr("+/", "-_").tr("=", "")

    EtsyAccount.create(state: state, code_verifier: code_verifier)

    "https://www.etsy.com/oauth/connect" \
    "?response_type=code" \
    "&client_id=#{api_key}" \
    "&redirect_uri=#{redirect_uri}" \
    "&scope=#{scope}" \
    "&state=#{state}" \
    "&code_challenge=#{code_challenge}" \
    "&code_challenge_method=S256"
  end

  def self.request_access_token(params)
    etsy_account = EtsyAccount.find_by(state: params[:state])
    if etsy_account.present?
      options = {
        grant_type: "authorization_code",
        client_id: api_key,
        redirect_uri: "#{ENV["ETSY_REDIRECT_URI_BASE"]}/etsy_response_listener",
        code: params[:code],
        code_verifier: etsy_account.code_verifier
      }
      response = JSON.parse(::Faraday.post("https://api.etsy.com/v3/public/oauth/token", options).body)
      etsy_account.access_token = response["access_token"]
      etsy_account.refresh_token = response["refresh_token"]
      etsy_account.expires_in = response["expires_in"]
      etsy_account.last_token_refresh = DateTime.now
      etsy_account.save
    else
      raise "The state provided to /etsy_response_listener was an invalid state, this could be a sign of a CSRF attack"
    end
  end

  class << self
    private

    def generate_state
      (25...50).map { ("a".."z").to_a[rand(26)] }.join
    end

    def generate_code_verifier
      (43...128).map { CODE_CHALLENGE_CHARACTERS[rand(CODE_CHALLENGE_CHARACTERS.count)] }.join
    end
  end
end

require_relative "betsy/engine" if defined?(Rails)
