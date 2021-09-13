require "spec_helper"

describe Betsy::LedgerEntry do
  describe "get_shop_payment_account_ledger_entries" do
    it "returns the shop payment account ledger entries" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/shops/1/payment-account/ledger-entries")
        .to_return(body: LEDGER_ENTRIES)
      ledger_entries = Betsy::LedgerEntry.get_shop_payment_account_ledger_entries(1)
      expect(ledger_entries).to be_an_instance_of Array
      expect(ledger_entries.first.entry_id).to eq 1
      expect(ledger_entries.first.ledger_id).to eq 1
      expect(ledger_entries.first.sequence_number).to eq 0
      expect(ledger_entries.first.amount).to eq 0
      expect(ledger_entries.first.currency).to eq "string"
      expect(ledger_entries.first.description).to eq "string"
      expect(ledger_entries.first.balance).to eq 0
      expect(ledger_entries.first.create_date).to eq 0
    end
  end
end
