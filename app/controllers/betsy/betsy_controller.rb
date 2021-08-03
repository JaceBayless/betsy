class Betsy::BetsyController < ApplicationController
  def etsy_response_listener
    Betsy.request_access_token(params)
  end
end
