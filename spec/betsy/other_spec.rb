require "spec_helper"

describe Betsy::Other do
  describe "ping" do
    it "returns the application id" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/openapi-ping")
        .to_return(body: PING)
      ping = Betsy::Other.ping
      expect(ping).to be_kind_of Betsy::Other
      expect(ping.application_id).to eq 1
    end
  end
end
