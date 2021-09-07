require "spec_helper"

describe Betsy::ShopListingFile do
  describe "delete_listing_file" do
    # IN THE DOCS IT APPEARS THIS HAS NO RETURN AS OF 9/5/21
    it "deletes a listing file" do
      stub_request(:delete, "https://openapi.etsy.com/v3/application/shops/1/listings/1/files/1")
      Betsy::ShopListingFile.delete_listing_file(1, 1, 1)
    end
  end

  describe "get_listing_file" do
    it "returns a listing file" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/files/1")
        .to_return(body: SINGLE_SHOP_LISTING_FILE)
      listing_file = Betsy::ShopListingFile.get_listing_file(1, 1, 1)
      expect(listing_file).to be_kind_of Betsy::ShopListingFile
      expect(listing_file.listing_file_id).to eq 1
      expect(listing_file.listing_id).to eq 1
      expect(listing_file.rank).to eq 0
      expect(listing_file.filename).to eq "string"
      expect(listing_file.filesize).to eq "string"
      expect(listing_file.size_bytes).to eq 0
      expect(listing_file.filetype).to eq "string"
      expect(listing_file.create_timestamp).to eq 946684800
    end
  end

  describe "get_all_listing_files" do
    it "returns all listing files for a listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/files")
        .to_return(body: MULTIPLE_SHOP_LISTING_FILES)
      listing_files = Betsy::ShopListingFile.get_all_listing_files(1, 1)
      expect(listing_files).to be_an_instance_of Array
      expect(listing_files.count).to eq 2
      expect(listing_files.first).to be_kind_of Betsy::ShopListingFile
      expect(listing_files.first.listing_file_id).to eq 1
    end
  end

  describe "upload_listing_file" do
    it "uploads a listing file" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/listings/1/files")
        .to_return(body: SINGLE_SHOP_LISTING_FILE)
      listing_file = Betsy::ShopListingFile.upload_listing_file(1, 1)
      expect(listing_file).to be_kind_of Betsy::ShopListingFile
      expect(listing_file.listing_file_id).to eq 1
    end
  end
end
