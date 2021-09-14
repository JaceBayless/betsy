require "spec_helper"

describe Betsy::ShopReceiptTransaction do
  describe "get_shop_receipt_transactions_by_listing" do
    it "gets receipt transactions by a listing" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/listings/1/transactions")
        .to_return(body: MULTIPLE_SHOP_RECEIPT_TRANSACTIONS)
      transactions = Betsy::ShopReceiptTransaction.get_shop_receipt_transactions_by_listing(1, 1)
      transaction = transactions.first
      expect(transactions).to be_an_instance_of Array
      expect(transaction).to be_kind_of Betsy::ShopReceiptTransaction
      expect(transaction.transaction_id).to eq 1
      expect(transaction.title).to eq "string"
      expect(transaction.description).to eq "string"
      expect(transaction.seller_user_id).to eq 1
      expect(transaction.buyer_user_id).to eq 1
      expect(transaction.create_timestamp).to eq 946684800
      expect(transaction.paid_timestamp).to eq 946684800
      expect(transaction.shipped_timestamp).to eq 946684800
      expect(transaction.quantity).to eq 0
      expect(transaction.listing_image_id).to eq 1
      expect(transaction.receipt_id).to eq 1
      expect(transaction.is_digital).to eq true
      expect(transaction.file_data).to eq "string"
      expect(transaction.listing_id).to eq 1
      expect(transaction.transaction_type).to eq "string"
      expect(transaction.product_id).to eq 1
      expect(transaction.price).to be_an_instance_of Hash
      expect(transaction.shipping_cost).to be_an_instance_of Hash
      expect(transaction.variations).to be_an_instance_of Array
    end
  end

  describe "get_shop_receipt_transactions_by_receipt" do
    it "gets receipt transactions by a receipt" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/receipts/1/transactions")
        .to_return(body: MULTIPLE_SHOP_RECEIPT_TRANSACTIONS)
      transactions = Betsy::ShopReceiptTransaction.get_shop_receipt_transactions_by_receipt(1, 1)
      transaction = transactions.first
      expect(transactions).to be_an_instance_of Array
      expect(transaction).to be_kind_of Betsy::ShopReceiptTransaction
      expect(transaction.transaction_id).to eq 1
    end
  end

  describe "get_shop_receipt_transaction" do
    it "gets a receipt transaction" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/transactions/1")
        .to_return(body: SINGLE_SHOP_RECEIPT_TRANSACTION)
      transaction = Betsy::ShopReceiptTransaction.get_shop_receipt_transaction(1, 1)
      expect(transaction).to be_kind_of Betsy::ShopReceiptTransaction
      expect(transaction.transaction_id).to eq 1
    end
  end

  describe "get_shop_receipt_transactions_by_shop" do
    it "gets all the receipt transactions for a shop" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/transactions")
        .to_return(body: MULTIPLE_SHOP_RECEIPT_TRANSACTIONS)
      transactions = Betsy::ShopReceiptTransaction.get_shop_receipt_transactions_by_shop(1)
      transaction = transactions.first
      expect(transactions).to be_an_instance_of Array
      expect(transaction).to be_kind_of Betsy::ShopReceiptTransaction
      expect(transaction.transaction_id).to eq 1
    end
  end
end
