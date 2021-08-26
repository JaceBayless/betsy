# frozen_string_literal: true

module Betsy
  class SellerTaxonomy
    include Betsy::Model

    # taxonomy nodes
    attribute :id
    attribute :level
    attribute :parent_id
    attribute :children
    attribute :full_path_taxonomy_ids

    # taxonomy nodes properties
    attribute :property_id
    attribute :display_name
    attribute :scales
    attribute :is_required
    attribute :supports_attributes
    attribute :supports_variations
    attribute :is_multivalued
    attribute :possible_values
    attribute :selected_values

    # both nodes and node properties
    attribute :name

    def self.get_seller_taxonomy_nodes
      make_request(:get, "/v3/application/seller-taxonomy/nodes")
    end

    def self.get_properties_by_taxonomy_id(taxonomy_id)
      make_request(:get, "/v3/application/seller-taxonomy/nodes/#{taxonomy_id}/properties")
    end
  end
end
