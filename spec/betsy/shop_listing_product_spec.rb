require "spec_helper"

describe Betsy::ShopListingProduct do
  describe "get_listing_product" do
    it "gets the product for a listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/listings/1/inventory/products/1")
        .to_return(body: SHOP_LISTING_PRODUCT)
      listing_product = Betsy::ShopListingProduct.get_listing_product(1, 1)
      expect(listing_product).to be_kind_of Betsy::ShopListingProduct
      expect(listing_product.product_id).to eq 1
      expect(listing_product.sku).to eq "string"
      expect(listing_product.is_deleted).to eq true
      expect(listing_product.offerings).to be_an_instance_of Array
      expect(listing_product.property_values).to be_an_instance_of Array
    end
  end
end
