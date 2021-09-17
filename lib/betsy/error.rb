# frozen_string_literal: true

module Betsy
  class Error
    include Betsy::Model

    attribute :status
    attribute :error
  end
end
