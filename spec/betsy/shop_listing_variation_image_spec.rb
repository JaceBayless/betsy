require "spec_helper"

describe Betsy::ShopListingVariationImage do
  describe "create_listing_translation" do
    it "gets variation images for a listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/variation-images")
        .to_return(status: 200, body: SHOP_LISTING_VARIATION_IMAGES)
      variation_images = Betsy::ShopListingVariationImage.get_listing_variation_images(1, 1)
      expect(variation_images).to be_an_instance_of Array
      expect(variation_images.first).to be_kind_of Betsy::ShopListingVariationImage
      expect(variation_images.first.property_id).to eq 1
      expect(variation_images.first.value_id).to eq 1
      expect(variation_images.first.image_id).to eq 1
    end
  end

  describe "update_variation_image" do
    it "updates variation images for a listing" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/listings/1/variation-images")
        .to_return(status: 200, body: SHOP_LISTING_VARIATION_IMAGES)
      variation_images = Betsy::ShopListingVariationImage.update_variation_images(1, 1)
      expect(variation_images).to be_an_instance_of Array
      expect(variation_images.first).to be_kind_of Betsy::ShopListingVariationImage
      expect(variation_images.first.property_id).to eq 1
    end
  end
end
