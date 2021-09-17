require "spec_helper"

describe Betsy::ShopListingInventory do
  describe "get_listing_inventory" do
    it "gets the inventory for a listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/listings/1/inventory")
        .to_return(status: 200, body: LISTING_INVENTORY)
      inventory = Betsy::ShopListingInventory.get_listing_inventory(1)
      expect(inventory).to be_kind_of Betsy::ShopListingInventory
      expect(inventory.products).to be_an_instance_of Array
      expect(inventory.price_on_property).to be_an_instance_of Array
      expect(inventory.quantity_on_property).to be_an_instance_of Array
      expect(inventory.sku_on_property).to be_an_instance_of Array
      expect(inventory.listing).to be_an_instance_of Hash
    end
  end

  describe "update_listing_inventory" do
    it "updates and returns the inventory for a listing" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/listings/1/inventory")
        .to_return(status: 200, body: LISTING_INVENTORY)
      inventory = Betsy::ShopListingInventory.update_listing_inventory(1)
      expect(inventory).to be_kind_of Betsy::ShopListingInventory
      expect(inventory.products).to be_an_instance_of Array
    end
  end
end
