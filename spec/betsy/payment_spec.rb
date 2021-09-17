require "spec_helper"

describe Betsy::Payment do
  describe "get_payment_account_ledger_entry_payments" do
    it "gets a payment from a payment account ledger entry ID" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/payment-account/ledger-entries/payments")
        .to_return(status: 200, body: PAYMENTS)
      payments = Betsy::Payment.get_payment_account_ledger_entry_payments(1)
      payment = payments.first
      expect(payments).to be_an_instance_of Array
      expect(payment).to be_kind_of Betsy::Payment
      expect(payment.payment_id).to eq 1
      expect(payment.buyer_user_id).to eq 1
      expect(payment.shop_id).to eq 1
      expect(payment.receipt_id).to eq 1
      expect(payment.amount_gross).to be_an_instance_of Hash
      expect(payment.amount_fees).to be_an_instance_of Hash
      expect(payment.amount_net).to be_an_instance_of Hash
      expect(payment.posted_gross).to be_an_instance_of Hash
      expect(payment.posted_fees).to be_an_instance_of Hash
      expect(payment.posted_net).to be_an_instance_of Hash
      expect(payment.adjusted_gross).to be_an_instance_of Hash
      expect(payment.adjusted_fees).to be_an_instance_of Hash
      expect(payment.adjusted_net).to be_an_instance_of Hash
      expect(payment.currency).to eq "string"
      expect(payment.shop_currency).to eq "string"
      expect(payment.buyer_currency).to eq "string"
      expect(payment.shipping_user_id).to eq 1
      expect(payment.shipping_address_id).to eq 1
      expect(payment.billing_address_id).to eq 1
      expect(payment.status).to eq "string"
      expect(payment.shipped_timestamp).to eq 946684800
      expect(payment.create_timestamp).to eq 946684800
      expect(payment.update_timestamp).to eq 946684800
      expect(payment.payment_adjustments).to be_an_instance_of Array
    end
  end

  describe "get_shop_payment_by_receipt_id" do
    it "gets a shop payment given a receipt id" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/receipts/1/payments")
        .to_return(status: 200, body: PAYMENTS)
      payments = Betsy::Payment.get_shop_payment_by_receipt_id(1, 1)
      expect(payments).to be_an_instance_of Array
      expect(payments.first).to be_kind_of Betsy::Payment
      expect(payments.first.payment_id).to eq 1
    end
  end

  describe "get_payments" do
    it "gets all the payments for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/payments")
        .to_return(status: 200, body: PAYMENTS)
      payments = Betsy::Payment.get_payments(1)
      expect(payments).to be_an_instance_of Array
      expect(payments.first).to be_kind_of Betsy::Payment
      expect(payments.first.payment_id).to eq 1
    end
  end
end
