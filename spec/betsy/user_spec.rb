require "spec_helper"

describe Betsy::User do
  describe "get_user" do
    it "returns a user" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/users/1")
        .to_return(status: 200, body: USER)
      user = Betsy::User.get_user(1)
      expect(user).to be_kind_of Betsy::User
      expect(user.user_id).to eq 1
      expect(user.primary_email).to eq "user@example.com"
      expect(user.first_name).to eq "string"
      expect(user.last_name).to eq "string"
      expect(user.image_url_75x75).to eq "string"
    end
  end

  describe "get_me" do
    it "returns a user" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/users/me")
        .to_return(status: 200, body: USER_ME)
      user = Betsy::User.get_me
      expect(user).to be_kind_of Betsy::User
      expect(user.user_id).to eq 1
      expect(user.shop_id).to eq 1
    end
  end
end
