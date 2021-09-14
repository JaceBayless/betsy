require "spec_helper"

describe Betsy::ShopReceipt do
  describe "get_shop_receipt" do
    it "returns a single shop receipt" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/receipts/1")
        .to_return(body: SINGLE_SHOP_RECEIPT)
      receipt = Betsy::ShopReceipt.get_shop_receipt(1, 1)
      expect(receipt).to be_kind_of Betsy::ShopReceipt
      expect(receipt.receipt_id).to eq 1
      expect(receipt.receipt_type).to eq 0
      expect(receipt.seller_user_id).to eq 1
      expect(receipt.seller_email).to eq "user@example.com"
      expect(receipt.buyer_user_id).to eq 1
      expect(receipt.buyer_email).to eq "user@example.com"
      expect(receipt.name).to eq "string"
      expect(receipt.first_line).to eq "string"
      expect(receipt.second_line).to eq "string"
      expect(receipt.city).to eq "string"
      expect(receipt.state).to eq "string"
      expect(receipt.zip).to eq "string"
      expect(receipt.formatted_address).to eq "string"
      expect(receipt.country_iso).to eq "string"
      expect(receipt.payment_method).to eq "string"
      expect(receipt.payment_email).to eq "string"
      expect(receipt.message_from_seller).to eq "string"
      expect(receipt.message_from_buyer).to eq "string"
      expect(receipt.message_from_payment).to eq "string"
      expect(receipt.is_paid).to eq true
      expect(receipt.is_shipped).to eq true
      expect(receipt.create_timestamp).to eq 946684800
      expect(receipt.update_timestamp).to eq 946684800
      expect(receipt.gift_message).to eq "string"
      expect(receipt.grandtotal).to be_an_instance_of Hash
      expect(receipt.subtotal).to be_an_instance_of Hash
      expect(receipt.total_price).to be_an_instance_of Hash
      expect(receipt.total_shipping_cost).to be_an_instance_of Hash
      expect(receipt.total_tax_cost).to be_an_instance_of Hash
      expect(receipt.total_vat_cost).to be_an_instance_of Hash
      expect(receipt.discount_amt).to be_an_instance_of Hash
      expect(receipt.gift_wrap_price).to be_an_instance_of Hash
      expect(receipt.shipments).to be_an_instance_of Array
      expect(receipt.transactions).to be_an_instance_of Array
    end
  end

  describe "get_shop_receipts" do
    it "returns receipts for a given shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/receipts")
        .to_return(body: MULTIPLE_SHOP_RECEIPTS)
      receipts = Betsy::ShopReceipt.get_shop_receipts(1)
      receipt = receipts.first
      expect(receipts).to be_an_instance_of Array
      expect(receipt).to be_kind_of Betsy::ShopReceipt
      expect(receipt.receipt_id).to eq 1
    end
  end

  describe "create_receipt_shipment" do
    it "updates the tracking on a receipt" do
      stub_request(:post, "https://openapi.etsy.com/v3/application/shops/1/receipts/1/tracking")
        .to_return(body: SINGLE_SHOP_RECEIPT)
      receipt = Betsy::ShopReceipt.create_receipt_shipment(1, 1)
      expect(receipt).to be_kind_of Betsy::ShopReceipt
      expect(receipt.receipt_id).to eq 1
    end
  end
end
