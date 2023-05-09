require "spec_helper"

describe Betsy::ShopListing do
  describe "create_draft_listing" do
    it "creates a draft listing given a shop id" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/listings")
        .to_return(status: 200, body: SINGLE_LISTING)
      listing = Betsy::ShopListing.create_draft_listing(1)
      expect(listing).to be_kind_of Betsy::ShopListing
      expect(listing.listing_id).to eq 1
      expect(listing.user_id).to eq 1
      expect(listing.shop_id).to eq 1
      expect(listing.title).to eq "string"
      expect(listing.description).to eq "string"
      expect(listing.state).to eq "0"
      expect(listing.creation_timestamp).to eq 946684800
      expect(listing.ending_timestamp).to eq 946684800
      expect(listing.original_creation_timestamp).to eq 946684800
      expect(listing.last_modified_timestamp).to eq 946684800
      expect(listing.state_timestamp).to eq 946684800
      expect(listing.quantity).to eq 0
      expect(listing.shop_section_id).to eq 1
      expect(listing.featured_rank).to eq 0
      expect(listing.url).to eq "string"
      expect(listing.num_favorers).to eq 0
      expect(listing.non_taxable).to eq true
      expect(listing.is_customizable).to eq true
      expect(listing.is_personalizable).to eq true
      expect(listing.personalization_is_required).to eq true
      expect(listing.personalization_char_count_max).to eq 0
      expect(listing.personalization_instructions).to eq "string"
      expect(listing.listing_type).to eq true
      expect(listing.tags).to be_an_instance_of Array
      expect(listing.materials).to be_an_instance_of Array
      expect(listing.shipping_profile_id).to eq 1
      expect(listing.processing_min).to eq 0
      expect(listing.processing_max).to eq 0
      expect(listing.who_made).to eq "i_did"
      expect(listing.when_made).to eq "made_to_order"
      expect(listing.is_supply).to eq true
      expect(listing.item_weight).to eq 0
      expect(listing.item_weight_unit).to eq "oz"
      expect(listing.item_length).to eq 0
      expect(listing.item_width).to eq 0
      expect(listing.item_height).to eq 0
      expect(listing.item_dimensions_unit).to eq "in"
      expect(listing.is_private).to eq true
      expect(listing.recipient).to eq "men"
      expect(listing.occasion).to eq "anniversary"
      expect(listing.style).to be_an_instance_of Array
      expect(listing.file_data).to eq "string"
      expect(listing.has_variations).to eq true
      expect(listing.should_auto_renew).to eq true
      expect(listing.language).to eq "string"
      expect(listing.price).to be_an_instance_of Hash
      expect(listing.taxonomy_id).to eq 0
      expect(listing.production_partners).to be_an_instance_of Array
      expect(listing.skus).to be_an_instance_of Array
      expect(listing.views).to eq 0
    end
  end

  describe "get_listings_by_shop" do
    it "returns an array of ShopListings" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings")
        .to_return(status: 200, body: MULTIPLE_LISTINGS)
      listings = Betsy::ShopListing.get_listings_by_shop(1)
      expect(listings.count).to eq 1
      expect(listings.first).to be_kind_of Betsy::ShopListing
      expect(listings.first.listing_id).to eq 1
    end
  end

  describe "delete_listing" do
    it "returns the ShopListing that was deleted" do
      stub_request(:delete, "https://openapi.etsy.com/v3/application/listings/1")
        .to_return(status: 200, body: SINGLE_LISTING)
      listing = Betsy::ShopListing.delete_listing(1)
      expect(listing).to be_kind_of Betsy::ShopListing
      expect(listing.listing_id).to eq 1
    end
  end

  describe "get_listing" do
    it "returns the requested listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/listings/1")
        .to_return(status: 200, body: SINGLE_LISTING)
      listing = Betsy::ShopListing.get_listing(1)
      expect(listing).to be_kind_of Betsy::ShopListing
      expect(listing.listing_id).to eq 1
    end
  end

  describe "find_all_listings_active" do
    it "returns an array of all active listings" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/listings/active")
        .to_return(status: 200, body: MULTIPLE_LISTINGS)
      listings = Betsy::ShopListing.find_all_listings_active
      expect(listings.count).to eq 1
      expect(listings.first).to be_kind_of Betsy::ShopListing
      expect(listings.first.listing_id).to eq 1
    end
  end

  describe "find_all_active_listings_by_shop" do
    it "returns an array of all active listings for the given shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/active")
        .to_return(status: 200, body: MULTIPLE_LISTINGS)
      listings = Betsy::ShopListing.find_all_active_listings_by_shop(1)
      expect(listings.count).to eq 1
      expect(listings.first).to be_kind_of Betsy::ShopListing
      expect(listings.first.listing_id).to eq 1
    end
  end

  describe "get_listings_by_listing_ids" do
    it "returns a list of listings given an array of ids" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/listings/batch")
        .to_return(status: 200, body: MULTIPLE_LISTINGS)
      listings = Betsy::ShopListing.get_listings_by_listing_ids
      expect(listings.count).to eq 1
      expect(listings.first).to be_kind_of Betsy::ShopListing
      expect(listings.first.listing_id).to eq 1
    end
  end

  describe "get_featured_listings_by_shop" do
    it "returns an array of featured listings for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/featured")
        .to_return(status: 200, body: MULTIPLE_LISTINGS)
      listings = Betsy::ShopListing.get_featured_listings_by_shop(1)
      expect(listings.count).to eq 1
      expect(listings.first).to be_kind_of Betsy::ShopListing
      expect(listings.first.listing_id).to eq 1
    end
  end

  describe "delete_listing_property" do
    # IN THE DOCS IT APPEARS THIS HAS NO RETURN AS OF 9/5/21
    it "deletes a listing property" do
      stub_request(:delete, "https://openapi.etsy.com/v3/application/shops/1/listings/1/properties/1")
      Betsy::ShopListing.delete_listing_property(1, 1, 1)
    end
  end

  describe "update_listing_property" do
    it "returns a listing property" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/shops/1/listings/1/properties/1")
        .to_return(status: 200, body: SINGLE_LISTING_PROPERTY)
      listing_property = Betsy::ShopListing.update_listing_property(1, 1, 1)
      expect(listing_property).to be_kind_of Betsy::ShopListing
      expect(listing_property.property_id).to eq 1
      expect(listing_property.property_name).to eq "string"
      expect(listing_property.scale_id).to eq 1
      expect(listing_property.scale_name).to eq "string"
      expect(listing_property.value_ids).to be_an_instance_of Array
      expect(listing_property.values).to be_an_instance_of Array
    end
  end

  describe "get_listing_properties" do
    it "returns an array of properties for a given listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/properties")
        .to_return(status: 200, body: MULTIPLE_LISTING_PROPERTIES)
      listing_properties = Betsy::ShopListing.get_listing_properties(1, 1)
      expect(listing_properties).to be_an_instance_of Array
      expect(listing_properties.count).to eq 2
      expect(listing_properties.first.property_id).to eq 1
    end
  end

  describe "update_listing" do
    it "updates a listing and returns the updated listing" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/shops/1/listings/1")
        .to_return(status: 200, body: SINGLE_LISTING)
      listing = Betsy::ShopListing.update_listing(1, 1)
      expect(listing).to be_kind_of Betsy::ShopListing
      expect(listing.listing_id).to eq 1
    end
  end

  describe "get_listings_by_shop_receipt" do
    it "returns listings given a shop and receipt id" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/receipts/1/listings")
        .to_return(status: 200, body: MULTIPLE_LISTINGS)
      listings = Betsy::ShopListing.get_listings_by_shop_receipt(1, 1)
      expect(listings.count).to eq 1
      expect(listings.first).to be_kind_of Betsy::ShopListing
      expect(listings.first.listing_id).to eq 1
    end
  end

  describe "get_listing_by_shop_section_id" do
    it "returns listing given a shop id" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/shop-sections/listings")
        .to_return(status: 200, body: MULTIPLE_LISTINGS)
      listings = Betsy::ShopListing.get_listings_by_shop_section_id(1)
      expect(listings.count).to eq 1
      expect(listings.first).to be_kind_of Betsy::ShopListing
      expect(listings.first.listing_id).to eq 1
    end
  end
end
