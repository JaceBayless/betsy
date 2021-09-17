require "spec_helper"

describe Betsy::ShopSection do
  describe "create_shop_section" do
    it "creates a shop section for a shop" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/sections")
        .to_return(body: SINGLE_SHOP_SECTION)
      section = Betsy::ShopSection.create_shop_section(1)
      expect(section).to be_kind_of Betsy::ShopSection
      expect(section.shop_section_id).to eq 1
      expect(section.title).to eq "string"
      expect(section.rank).to eq 0
      expect(section.user_id).to eq 1
      expect(section.active_listing_count).to eq 0
    end
  end

  describe "get_shop_sections" do
    it "gets the sections for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/sections")
        .to_return(body: MULTIPLE_SHOP_SECTIONS)
      sections = Betsy::ShopSection.get_shop_sections(1)
      section = sections.first
      expect(sections).to be_an_instance_of Array
      expect(section).to be_kind_of Betsy::ShopSection
      expect(section.shop_section_id).to eq 1
    end
  end

  describe "get_shop_section" do
    it "gets an individual shop section" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/sections/1")
        .to_return(body: SINGLE_SHOP_SECTION)
      section = Betsy::ShopSection.get_shop_section(1, 1)
      expect(section).to be_kind_of Betsy::ShopSection
      expect(section.shop_section_id).to eq 1
    end
  end
end
