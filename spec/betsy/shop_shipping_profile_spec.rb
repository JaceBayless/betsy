require "spec_helper"

describe Betsy::ShopShippingProfile do
  describe "get_shipping_carriers" do
    it "returns a list of shipping carriers" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shipping-carriers")
        .to_return(status: 200, body: SHIPPING_CARRIERS)
      shipping_carriers = Betsy::ShopShippingProfile.get_shipping_carriers
      shipping_carrier = shipping_carriers.first
      expect(shipping_carriers).to be_an_instance_of Array
      expect(shipping_carrier).to be_kind_of Betsy::ShopShippingProfile
      expect(shipping_carrier.shipping_carrier_id).to eq 1
      expect(shipping_carrier.name).to eq "string"
      expect(shipping_carrier.domestic_classes).to be_an_instance_of Array
      expect(shipping_carrier.international_classes).to be_an_instance_of Array
    end
  end

  describe "create_shop_shipping_profile" do
    it "creates a shop shipping profile" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles")
        .to_return(status: 200, body: SINGLE_SHIPPING_PROFILE)
      shipping_profile = Betsy::ShopShippingProfile.create_shop_shipping_profile(1)
      expect(shipping_profile).to be_kind_of Betsy::ShopShippingProfile
      expect(shipping_profile.shipping_profile_id).to eq 1
      expect(shipping_profile.title).to eq "string"
      expect(shipping_profile.user_id).to eq 1
      expect(shipping_profile.min_processing_days).to eq 0
      expect(shipping_profile.max_processing_days).to eq 0
      expect(shipping_profile.processing_days_display_label).to eq "string"
      expect(shipping_profile.origin_country_iso).to eq "string"
      expect(shipping_profile.is_deleted).to eq true
      expect(shipping_profile.shipping_profile_destinations).to be_an_instance_of Array
      expect(shipping_profile.shipping_profile_upgrades).to be_an_instance_of Array
      expect(shipping_profile.origin_postal_code).to eq "string"
      expect(shipping_profile.profile_type).to eq "manual"
    end
  end

  describe "get_shop_shipping_profiles" do
    it "gets shipping profiles for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles")
        .to_return(status: 200, body: MUTLIPLE_SHIPPING_PROFILES)
      shipping_profiles = Betsy::ShopShippingProfile.get_shop_shipping_profiles(1)
      shipping_profile = shipping_profiles.first
      expect(shipping_profiles).to be_an_instance_of Array
      expect(shipping_profile).to be_kind_of Betsy::ShopShippingProfile
      expect(shipping_profile.shipping_profile_id).to eq 1
    end
  end

  describe "delete_shop_shipping_profile" do
    # IN THE DOCS IT APPEARS THIS HAS NO RETURN AS OF 9/5/21
    it "deletes a shipping profile" do
      stub_request(:delete, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1")
      Betsy::ShopShippingProfile.delete_shop_shipping_profile(1, 1)
    end
  end

  describe "get_shop_shipping_profile" do
    it "gets a shipping profile by id" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1")
        .to_return(status: 200, body: SINGLE_SHIPPING_PROFILE)
      shipping_profile = Betsy::ShopShippingProfile.get_shop_shipping_profile(1, 1)
      expect(shipping_profile).to be_kind_of Betsy::ShopShippingProfile
      expect(shipping_profile.shipping_profile_id).to eq 1
    end
  end

  describe "update_shop_shipping_profile" do
    it "updates a shipping profile by id" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1")
        .to_return(status: 200, body: SINGLE_SHIPPING_PROFILE)
      shipping_profile = Betsy::ShopShippingProfile.update_shop_shipping_profile(1, 1)
      expect(shipping_profile).to be_kind_of Betsy::ShopShippingProfile
      expect(shipping_profile.shipping_profile_id).to eq 1
    end
  end

  describe "create_shop_shipping_profile_destination" do
    it "creates a shop shipping profile destination" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/destinations")
        .to_return(status: 200, body: SINGLE_SHIPPING_PROFILE_DESTINATION)
      destination = Betsy::ShopShippingProfile.create_shop_shipping_profile_destination(1, 1)
      expect(destination).to be_kind_of Betsy::ShopShippingProfile
      expect(destination.shipping_profile_destination_id).to eq 1
      expect(destination.shipping_profile_id).to eq 1
      expect(destination.origin_country_iso).to eq "string"
      expect(destination.destination_region).to eq "eu"
      expect(destination.primary_cost).to be_an_instance_of Hash
      expect(destination.secondary_cost).to be_an_instance_of Hash
      expect(destination.shipping_carrier_id).to eq 0
      expect(destination.mail_class).to eq "string"
      expect(destination.min_delivery_days).to eq 1
      expect(destination.max_delivery_days).to eq 1
    end
  end

  describe "create_shop_shipping_profile_destination" do
    it "creates a shop shipping profile destination" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/destinations")
        .to_return(status: 200, body: MULTIPLE_SHIPPING_PROFILE_DESTINATIONS)
      destinations = Betsy::ShopShippingProfile.get_shop_shipping_profile_destinations_by_shipping_profile(1, 1)
      destination = destinations.first
      expect(destinations).to be_an_instance_of Array
      expect(destination).to be_kind_of Betsy::ShopShippingProfile
      expect(destination.shipping_profile_destination_id).to eq 1
    end
  end

  describe "delete_shop_shipping_profile_destination" do
    it "deletes a shop shipping profile destination" do
      stub_request(:delete, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/destinations/1")
      Betsy::ShopShippingProfile.delete_shop_shipping_profile_destination(1, 1, 1)
    end
  end

  describe "update_shop_shipping_profile_destination" do
    it "updates a shop shipping profile destination" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/destinations/1")
        .to_return(status: 200, body: SINGLE_SHIPPING_PROFILE_DESTINATION)
      destination = Betsy::ShopShippingProfile.update_shop_shipping_profile_destination(1, 1, 1)
      expect(destination).to be_kind_of Betsy::ShopShippingProfile
      expect(destination.shipping_profile_destination_id).to eq 1
    end
  end

  describe "create_shop_shipping_profile_upgrade" do
    it "creates a shop shipping profile upgrade" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/upgrades")
        .to_return(status: 200, body: SINGLE_SHIPPING_PROFILE_UPGRADE)
      upgrade = Betsy::ShopShippingProfile.create_shop_shipping_profile_upgrade(1, 1)
      expect(upgrade).to be_kind_of Betsy::ShopShippingProfile
      expect(upgrade.shipping_profile_id).to eq 1
      expect(upgrade.upgrade_id).to eq 1
      expect(upgrade.upgrade_name).to eq "string"
      expect(upgrade.type).to eq "0"
      expect(upgrade.rank).to eq 0
      expect(upgrade.language).to eq "string"
      expect(upgrade.price).to be_an_instance_of Hash
      expect(upgrade.secondary_price).to be_an_instance_of Hash
      expect(upgrade.shipping_carrier_id).to eq 0
      expect(upgrade.mail_class).to eq "string"
      expect(upgrade.min_delivery_days).to eq 1
      expect(upgrade.max_delivery_days).to eq 1
    end
  end

  describe "get_shop_shipping_profile_upgrades" do
    it "gets all shipping profile upgrades for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/upgrades")
        .to_return(status: 200, body: MULTIPLE_SHIPPING_PROFILE_UPGRADES)
      upgrades = Betsy::ShopShippingProfile.get_shop_shipping_profile_upgrades(1, 1)
      upgrade = upgrades.first
      expect(upgrades).to be_an_instance_of Array
      expect(upgrade).to be_kind_of Betsy::ShopShippingProfile
      expect(upgrade.shipping_profile_id).to eq 1
    end
  end

  describe "delete_shop_shipping_profile_upgrade" do
    it "deletes a shipping profile upgrade" do
      stub_request(:delete, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/upgrades/1")
      Betsy::ShopShippingProfile.delete_shop_shipping_profile_upgrade(1, 1, 1)
    end
  end

  describe "update_shop_shipping_profile_upgrade" do
    it "updates a shipping profile upgrade" do
      stub_request(:put, "https://openapi.etsy.com/v3/application/shops/1/shipping-profiles/1/upgrades/1")
        .to_return(status: 200, body: SINGLE_SHIPPING_PROFILE_UPGRADE)
      upgrade = Betsy::ShopShippingProfile.update_shop_shipping_profile_upgrade(1, 1, 1)
      expect(upgrade).to be_kind_of Betsy::ShopShippingProfile
      expect(upgrade.shipping_profile_id).to eq 1
    end
  end
end
