require "spec_helper"

describe Betsy::ShopListingImage do
  describe "delete_listing_image" do
    # IN THE DOCS IT APPEARS THIS HAS NO RETURN AS OF 9/5/21
    it "deletes a listing image" do
      stub_request(:delete, "https://openapi.etsy.com/v3/application/shops/1/listings/1/images/1")
      Betsy::ShopListingImage.delete_listing_image(1, 1, 1)
    end
  end

  describe "get_listing_image" do
    it "returns a listing image" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/images/1")
        .to_return(status: 200, body: SINGLE_SHOP_LISTING_IMAGE)
      listing_image = Betsy::ShopListingImage.get_listing_image(1, 1, 1)
      expect(listing_image).to be_kind_of Betsy::ShopListingImage
      expect(listing_image.listing_id).to eq 1
      expect(listing_image.listing_image_id).to eq 1
      expect(listing_image.hex_code).to eq "string"
      expect(listing_image.red).to eq 0
      expect(listing_image.green).to eq 0
      expect(listing_image.blue).to eq 0
      expect(listing_image.hue).to eq 0
      expect(listing_image.saturation).to eq 0
      expect(listing_image.brightness).to eq 0
      expect(listing_image.is_black_and_white).to eq true
      expect(listing_image.creation_tsz).to eq 0
      expect(listing_image.rank).to eq 0
      expect(listing_image.url_75x75).to eq "string"
      expect(listing_image.url_170x135).to eq "string"
      expect(listing_image.url_570xN).to eq "string"
      expect(listing_image.url_fullxfull).to eq "string"
      expect(listing_image.full_height).to eq 0
      expect(listing_image.full_width).to eq 0
    end
  end

  describe "get_listing_images" do
    it "returns all listing images for a listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/images")
        .to_return(status: 200, body: MULTIPLE_SHOP_LISTING_IMAGES)
      listing_images = Betsy::ShopListingImage.get_listing_images(1, 1)
      expect(listing_images).to be_an_instance_of Array
      expect(listing_images.count).to eq 2
      expect(listing_images.first).to be_kind_of Betsy::ShopListingImage
      expect(listing_images.first.listing_id).to eq 1
    end
  end

  describe "upload_listing_image" do
    it "uploads a listing image" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/listings/1/images")
        .to_return(status: 200, body: SINGLE_SHOP_LISTING_IMAGE)
      listing_image = Betsy::ShopListingImage.upload_listing_image(1, 1)
      expect(listing_image).to be_kind_of Betsy::ShopListingImage
      expect(listing_image.listing_id).to eq 1
    end
  end
end
