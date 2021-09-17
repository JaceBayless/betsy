require "spec_helper"
require "action_controller"

describe Betsy do
  describe "authorization_url" do
    it "errors when there is no api_key present" do
      Betsy.api_key = nil
      expect { Betsy.authorization_url }.to raise_error("Betsy.api_key must be set")
    end

    it "errors when there is no redirect_uri_base present" do
      Betsy.redirect_uri_base = nil
      expect { Betsy.authorization_url }.to raise_error("Betsy.redirect_uri_base must be set")
    end

    it "errors when there is no redirect_uri_base present" do
      Betsy.api_key = nil
      Betsy.redirect_uri_base = nil
      expect { Betsy.authorization_url }.to raise_error("Betsy.api_key and Betsy.redirect_uri_base must be set")
    end

    it "creates a EtsyAccount when generating an authorization_url" do
      Betsy.authorization_url
      expect(EtsyAccount.count).to eq(1)
    end

    it "returns a valid authorization_url when not passed any scopes" do
      authorization_url = Betsy.authorization_url
      expect(authorization_url).to include("https://www.etsy.com/oauth/connect")
      expect(authorization_url).to include("&scope=address_r%20address_w%20billing_r%20cart_r%20cart_w%20email_r%20favorites_r")
    end

    it "returns a valid authoirzation_url with correct scopes when passed" do
      authorization_url = Betsy.authorization_url(scope: ["address_r", "address_w"])
      expect(authorization_url).to include("https://www.etsy.com/oauth/connect")
      expect(authorization_url).to include("&scope=address_r%20address_w&")
    end
  end

  describe "request_access_token" do
    it "throws error when passed a state that does not exist" do
      params = ActionController::Parameters.new(state: "invalidstate", code: "abc123")
      expect { Betsy.request_access_token(params) }.to raise_error("The state provided to /etsy_response_listener was an invalid state, this could be a sign of a CSRF attack")
    end

    it "properly updates etsy_account after Posting code back to Etsy" do
      valid_response = '{
          "access_token": "12345678.O1zLuwveeKjpIqCQFfmR-PaMMpBmagH6DljRAkK9qt05OtRKiANJOyZlMx3WQ_o2FdComQGuoiAWy3dxyGI4Ke_76PR",
          "token_type": "Bearer",
          "expires_in": 86400,
          "refresh_token": "12345678.JNGIJtvLmwfDMhlYoOJl8aLR1BWottyHC6yhNcET-eC7RogSR5e1GTIXGrgrelWZalvh3YvvyLfKYYqvymd-u37Sjtx"
      }'
      stub_request(:post, "https://api.etsy.com/v3/public/oauth/token")
        .to_return(status: 200, body: valid_response)

      EtsyAccount.create!(state: "validstate", code_verifier: "zangerbob")
      params = ActionController::Parameters.new(state: "validstate", code: "thomasthetrainengineisfast")
      Betsy.request_access_token(params)
      expect(EtsyAccount.find_by(state: "validstate").access_token).to eq("12345678.O1zLuwveeKjpIqCQFfmR-PaMMpBmagH6DljRAkK9qt05OtRKiANJOyZlMx3WQ_o2FdComQGuoiAWy3dxyGI4Ke_76PR")
    end
  end
end
