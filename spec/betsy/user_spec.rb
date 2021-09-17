require "spec_helper"

describe Betsy::User do
  describe "get_user" do
    it "returns a user" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/users/1")
        .to_return(body: USER)
      user = Betsy::User.get_user(1)
      expect(user).to be_kind_of Betsy::User
      expect(user.user_id).to eq 1
      expect(user.login_name).to eq "string"
      expect(user.primary_email).to eq "user@example.com"
      expect(user.first_name).to eq "string"
      expect(user.last_name).to eq "string"
      expect(user.create_timestamp).to eq 946684800
      expect(user.referred_by_user_id).to eq 1
      expect(user.use_new_inventory_endpoints).to eq true
      expect(user.is_seller).to eq true
      expect(user.bio).to eq "string"
      expect(user.gender).to eq "string"
      expect(user.birth_month).to eq "string"
      expect(user.birth_day).to eq "string"
      expect(user.transaction_buy_count).to eq 0
      expect(user.transaction_sold_count).to eq 0
    end
  end
end
