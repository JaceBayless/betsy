require "spec_helper"

describe Betsy::ShopListingOffering do
  describe "get_listing_offering" do
    it "gets the offering for a listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/listings/1/products/1/offerings/1")
        .to_return(body: SHOP_LISTING_OFFERING)
      listing_offering = Betsy::ShopListingOffering.get_listing_offering(1, 1, 1)
      expect(listing_offering).to be_kind_of Betsy::ShopListingOffering
      expect(listing_offering.offering_id).to eq 1
      expect(listing_offering.quantity).to eq 0
      expect(listing_offering.is_enabled).to eq true
      expect(listing_offering.is_deleted).to eq true
      expect(listing_offering.price).to be_an_instance_of Hash
    end
  end
end
