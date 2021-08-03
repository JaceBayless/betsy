Betsy::Engine.routes.draw do
  get "/etsy_response_listener", to: "betsy#etsy_response_listener"
end
