require "spec_helper"

module Betsy
  class Test
    include Model
    attribute :test_attr
  end
end

describe Betsy::Model do
  describe "initialize" do
    it "has no result value when no data is passed to initializer" do
      expect(Betsy::Test.new.instance_variable_get("@result")).to eq(nil)
    end

    it "has result data when data is passed to intializer" do
      expect(Betsy::Test.new({test_attr: "testing"}).instance_variable_get("@result")).to eq({test_attr: "testing"})
    end
  end

  describe "included" do
    it "properly extends ClassMethods methods" do
      expect(Betsy::Test.methods).to include(:attribute)
      expect(Betsy::Test.methods).to include(:make_request)
      expect(Betsy::Test.methods).to include(:check_token_expiration)
      expect(Betsy::Test.methods).to include(:access_credentials)
      expect(Betsy::Test.methods).to include(:handle_response)
    end
  end

  describe "ClassMethods#attribute" do
    it "creates a method for accessing an attribute" do
      expect(Betsy::Test.new.methods).to include(:test_attr)
    end

    it "properly returns the value when the method is called" do
      stub_request(:any, "https://openapi.etsy.com/endpoint")
        .to_return(status: 200, body: '{"test_attr": "test"}')
      expect(Betsy::Test.make_request(:get, "/endpoint").test_attr).to eq("test")
    end
  end

  describe "ClassMethods#make_request" do
    it "can make make get, post, put, patch, and delete calls" do
      stub_request(:any, "https://openapi.etsy.com/endpoint")
        .to_return(status: 200, body: '{"test_attr": "test"}')
      expect(Betsy::Test.make_request(:get, "/endpoint")).to be_kind_of(Betsy::Test)
      expect(Betsy::Test.make_request(:post, "/endpoint")).to be_kind_of(Betsy::Test)
      expect(Betsy::Test.make_request(:put, "/endpoint")).to be_kind_of(Betsy::Test)
      expect(Betsy::Test.make_request(:patch, "/endpoint")).to be_kind_of(Betsy::Test)
      expect(Betsy::Test.make_request(:delete, "/endpoint")).to be_kind_of(Betsy::Test)
    end

    it "checks token expiration and deletes etsy_account from options" do
      stub_request(:any, "https://openapi.etsy.com/endpoint")
        .to_return(status: 200, body: '{"test_attr": "test"}')
      stub_request(:post, "https://api.etsy.com/v3/public/oauth/token")
        .to_return(status: 200, body: '{"access_token": "refreshed_token", "expires_in": 3600, "refresh_token": "refreshed_refresh_token"}')
      etsy_account = EtsyAccount.create!(access_token: "token", refresh_token: "refresh", expires_in: 0, state: "state", code_verifier: "code_verifier", last_token_refresh: DateTime.now - 60)
      Betsy::Test.make_request(:get, "/endpoint", etsy_account: etsy_account)
      expect(etsy_account.access_token).to eq "refreshed_token"
      expect(etsy_account.expires_in).to eq 3600
      expect(etsy_account.refresh_token).to eq "refreshed_refresh_token"
    end
  end

  describe "ClassMethods#check_token_expiration" do
    it "does not attempt to refresh the token if it is not expired" do
      start_time = DateTime.now
      etsy_account = EtsyAccount.create!(access_token: "token", refresh_token: "refresh", expires_in: 1000, state: "state", code_verifier: "code_verifier", last_token_refresh: start_time)
      Betsy::Test.check_token_expiration(etsy_account)
      expect(etsy_account.access_token).to eq "token"
      expect(etsy_account.expires_in).to eq 1000
      expect(etsy_account.refresh_token).to eq "refresh"
      expect(etsy_account.last_token_refresh).to eq start_time
    end

    it "refreshes the access token, expiration time, refresh token and last token refresh time" do
      stub_request(:post, "https://api.etsy.com/v3/public/oauth/token")
        .to_return(status: 200, body: '{"access_token": "refreshed_token", "expires_in": 3600, "refresh_token": "refreshed_refresh_token"}')
      etsy_account = EtsyAccount.create!(access_token: "token", refresh_token: "refresh", expires_in: 0, state: "state", code_verifier: "code_verifier", last_token_refresh: DateTime.now - 60)
      Betsy::Test.check_token_expiration(etsy_account)
      expect(etsy_account.access_token).to eq "refreshed_token"
      expect(etsy_account.expires_in).to eq 3600
      expect(etsy_account.refresh_token).to eq "refreshed_refresh_token"
      expect(etsy_account.last_token_refresh).to be > DateTime.now - 60
    end
  end

  describe "ClassMethods#access_credentials" do
    it "does not add the access token to the header if passed nil instead of an etsy_account" do
      expect(Betsy::Test.access_credentials(nil)).to eq({x_api_key: Betsy.api_key})
    end

    it "adds the access token to the header if passed an etsy_account" do
      etsy_account = EtsyAccount.create!(access_token: "token")
      expect(Betsy::Test.access_credentials(etsy_account)).to eq({x_api_key: Betsy.api_key, Authorization: "Bearer token"})
    end
  end

  describe "ClassMethods#handle_response" do
    it "returns one object if count is present in response" do
      stub_request(:get, "https://www.testing.com").to_return(status: 200, body: '{"test_attr": "test"}')
      expect(Betsy::Test.handle_response(Faraday.get("https://www.testing.com"))).to be_kind_of(Betsy::Test)
    end

    it "returns multiple objects if count is present in response" do
      stub_request(:get, "https://www.testing.com")
        .to_return(status: 200, body: '{ "count": 2, "results": [{ "test_attr": "test1" }, { "test_attr": "test2" }] }')
      response = Betsy::Test.handle_response(Faraday.get("https://www.testing.com"))
      expect(response).to be_an_instance_of(Array)
      expect(response.count).to eq 2
    end

    it "returns a Betsy::Error when the return status is not 200" do
      stub_request(:get, "https://www.testing.com")
        .to_return(status: 500, body: '{ "error": "string" }')
      response = Betsy::Test.handle_response(Faraday.get("https://www.testing.com"))
      expect(response).to be_kind_of Betsy::Error
      expect(response.status).to eq 500
      expect(response.error).to eq "string"
    end
  end

  describe "ClassMethods#build_objects" do
    it "builds multiple objects when there is there are multiple results" do
      stub_request(:get, "https://www.testing.com")
        .to_return(status: 200, body: '{ "count": 2, "results": [{ "test_attr": "test1" }, { "test_attr": "test2" }] }')
      body = JSON.parse(Faraday.get("https://www.testing.com").body)
      response = Betsy::Test.build_objects(body)
      expect(response).to be_an_instance_of Array
      expect(response.first).to be_kind_of Betsy::Test
    end

    it "returns a single object when there is only one result" do
      stub_request(:get, "https://www.testing.com")
        .to_return(status: 200, body: '{ "test_attr": "test1" }')
      body = JSON.parse(Faraday.get("https://www.testing.com").body)
      response = Betsy::Test.build_objects(body)
      expect(response).to be_kind_of Betsy::Test
      expect(response.test_attr).to eq "test1"
    end
  end
end
