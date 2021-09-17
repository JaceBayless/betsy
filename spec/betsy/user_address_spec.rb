require "spec_helper"

describe Betsy::UserAddress do
  describe "get_user_addresses" do
    it "returns a list of the users address" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/user/addresses")
        .to_return(status: 200, body: USER_ADDRESSES)
      addresses = Betsy::UserAddress.get_user_addresses
      address = addresses.first
      expect(addresses).to be_an_instance_of Array
      expect(address).to be_kind_of Betsy::UserAddress
      expect(address.user_address_id).to eq 1
      expect(address.user_id).to eq 1
      expect(address.name).to eq "string"
      expect(address.first_line).to eq "string"
      expect(address.second_line).to eq "string"
      expect(address.city).to eq "string"
      expect(address.state).to eq "string"
      expect(address.zip).to eq "string"
      expect(address.iso_country_code).to eq "string"
      expect(address.country_name).to eq "string"
      expect(address.is_default_shipping_address).to eq true
    end
  end
end
