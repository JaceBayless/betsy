require "spec_helper"

describe Betsy::SellerTaxonomy do
  describe "get_seller_taxonomy_nodes" do
    it "returns an array of seller taxonomy objects with all data when a request is made" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/seller-taxonomy/nodes")
        .to_return(status: 200, body: SELLER_TAXONOMY_NODES)
      seller_taxonomy_nodes = Betsy::SellerTaxonomy.get_seller_taxonomy_nodes
      first = seller_taxonomy_nodes.first
      expect(seller_taxonomy_nodes).to be_an_instance_of Array
      expect(seller_taxonomy_nodes.count).to eq 1
      expect(first).to be_kind_of Betsy::SellerTaxonomy
      expect(first.id).to eq 1
      expect(first.level).to eq 0
      expect(first.name).to eq "string"
      expect(first.children).to be_an_instance_of Array
      expect(first.full_path_taxonomy_ids).to be_an_instance_of Array
      expect(first.property_id).to eq nil
    end
  end

  describe "get_properties_by_taxonomy_id" do
    it "returns an array of seller taxonomy objects with all data when a request is made" do
      stub_request(:get, "https://openapi.etsy.com/v3/application/seller-taxonomy/nodes/1/properties")
        .to_return(status: 200, body: SELLER_TAXONOMY_NODE_PROPERTIES)
      node_properties = Betsy::SellerTaxonomy.get_properties_by_taxonomy_id(1)
      first = node_properties.first
      expect(node_properties).to be_an_instance_of Array
      expect(node_properties.count).to eq 1
      expect(first).to be_kind_of Betsy::SellerTaxonomy
      expect(first.property_id).to eq 1
      expect(first.name).to eq "string"
      expect(first.display_name).to eq "string"
      expect(first.scales).to be_an_instance_of Array
      expect(first.is_required).to eq true
      expect(first.supports_attributes).to eq true
      expect(first.supports_variations).to eq true
      expect(first.is_multivalued).to eq true
      expect(first.possible_values).to be_an_instance_of Array
      expect(first.selected_values).to be_an_instance_of Array
      expect(first.id).to eq nil
    end
  end
end
