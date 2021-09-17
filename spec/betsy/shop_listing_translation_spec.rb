require "spec_helper"

describe Betsy::ShopListingTranslation do
  describe "create_listing_translation" do
    it "creates a translation for a listing" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/listings/1/translations/1")
        .to_return(status: 200, body: SHOP_LISTING_TRANSLATION)
      listing_translation = Betsy::ShopListingTranslation.create_listing_translation(1, 1, 1)
      expect(listing_translation).to be_kind_of Betsy::ShopListingTranslation
      expect(listing_translation.listing_id).to eq 1
      expect(listing_translation.language).to eq "string"
      expect(listing_translation.title).to eq "string"
      expect(listing_translation.description).to eq "string"
      expect(listing_translation.tags).to be_an_instance_of Array
    end
  end

  describe "get_listing_translation" do
    it "gets a translation for a listing given a shop, listing, and language" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/translations/1")
        .to_return(status: 200, body: SHOP_LISTING_TRANSLATION)
      listing_translation = Betsy::ShopListingTranslation.get_listing_translation(1, 1, 1)
      expect(listing_translation).to be_kind_of Betsy::ShopListingTranslation
      expect(listing_translation.listing_id).to eq 1
    end
  end

  describe "update_listing_translation" do
    it "updates a translation for a listing" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/shops/1/listings/1/translations/1")
        .to_return(status: 200, body: SHOP_LISTING_TRANSLATION)
      listing_translation = Betsy::ShopListingTranslation.update_listing_translation(1, 1, 1)
      expect(listing_translation).to be_kind_of Betsy::ShopListingTranslation
      expect(listing_translation.listing_id).to eq 1
    end
  end
end
