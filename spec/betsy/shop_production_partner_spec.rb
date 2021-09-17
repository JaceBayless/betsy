require "spec_helper"

describe Betsy::ShopProductionPartner do
  describe "get_shop_production_partners" do
    it "returns production partners for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/production-partners")
        .to_return(status: 200, body: SHOP_PRODUCTION_PARTNERS)
      partners = Betsy::ShopProductionPartner.get_shop_production_partners(1)
      partner = partners.first
      expect(partners).to be_an_instance_of Array
      expect(partner).to be_kind_of Betsy::ShopProductionPartner
      expect(partner.production_partner_id).to eq 1
      expect(partner.partner_name).to eq "string"
      expect(partner.location).to eq "string"
    end
  end
end
