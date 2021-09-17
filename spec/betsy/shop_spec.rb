require "spec_helper"

describe Betsy::Shop do
  describe "get_shop" do
    it "returns a shop object with all data when a request is made" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1")
        .to_return(status: 200, body: SINGLE_SHOP)
      shop = Betsy::Shop.get_shop("1")
      expect(shop).to be_kind_of(Betsy::Shop)
      expect(shop.shop_id).to eq 1
      expect(shop.user_id).to eq 1
      expect(shop.shop_name).to eq "string"
      expect(shop.create_date).to eq 0
      expect(shop.title).to eq "string"
      expect(shop.announcement).to eq "string"
      expect(shop.currency_code).to eq "string"
      expect(shop.is_vacation).to eq true
      expect(shop.vacation_message).to eq "string"
      expect(shop.sale_message).to eq "string"
      expect(shop.digital_sale_message).to eq "string"
      expect(shop.update_date).to eq 0
      expect(shop.listing_active_count).to eq 0
      expect(shop.digital_listing_count).to eq 0
      expect(shop.login_name).to eq "string"
      expect(shop.accepts_custom_requests).to eq true
      expect(shop.policy_welcome).to eq "string"
      expect(shop.policy_payment).to eq "string"
      expect(shop.policy_shipping).to eq "string"
      expect(shop.policy_refunds).to eq "string"
      expect(shop.policy_additional).to eq "string"
      expect(shop.policy_seller_info).to eq "string"
      expect(shop.policy_update_date).to eq 0
      expect(shop.policy_has_private_receipt_info).to eq true
      expect(shop.has_unstructured_policies).to eq true
      expect(shop.policy_privacy).to eq "string"
      expect(shop.vacation_autoreply).to eq "string"
      expect(shop.url).to eq "string"
      expect(shop.image_url_760x100).to eq "string"
      expect(shop.num_favorers).to eq 0
      expect(shop.languages).to be_an_instance_of Array
      expect(shop.icon_url_fullxfull).to eq "string"
      expect(shop.is_using_structured_policies).to eq true
      expect(shop.has_onboarded_structured_policies).to eq true
      expect(shop.include_dispute_form_link).to eq true
      expect(shop.is_direct_checkout_onboarded).to eq true
      expect(shop.is_calculated_eligible).to eq true
      expect(shop.is_opted_in_to_buyer_promise).to eq true
      expect(shop.is_shop_us_based).to eq true
      expect(shop.transaction_sold_count).to eq 0
      expect(shop.shipping_from_country_iso).to eq "string"
      expect(shop.shop_location_country_iso).to eq "string"
      expect(shop.review_count).to eq 0
      expect(shop.review_average).to eq 0
    end
  end

  describe "update_shop" do
    it "returns a shop" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/shops/1")
        .to_return(status: 200, body: SINGLE_SHOP)
      etsy_account = EtsyAccount.create!(access_token: "token", refresh_token: "refresh", expires_in: 3600, state: "state", code_verifier: "code_verifier", last_token_refresh: DateTime.now)
      shop = Betsy::Shop.update_shop("1", etsy_account: etsy_account, announcement: "Testing")
      expect(shop).to be_kind_of(Betsy::Shop)
      expect(shop.shop_id).to eq 1
    end
  end

  describe "get_shop_by_owner_user_id" do
    it "returns a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/users/1/shops")
        .to_return(status: 200, body: SINGLE_SHOP)
      shop = Betsy::Shop.get_shop_by_owner_user_id(1)
      expect(shop).to be_kind_of(Betsy::Shop)
      expect(shop.shop_id).to eq 1
    end
  end

  describe "find_shops" do
    it "multiple shops" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops?shop_name=test")
        .to_return(status: 200, body: MULTIPLE_SHOPS)
      shops = Betsy::Shop.find_shops("test")
      expect(shops).to be_an_instance_of Array
      expect(shops.count).to eq 2
      expect(shops.first.shop_id).to eq 1
      expect(shops.second.shop_id).to eq 1
    end
  end
end
