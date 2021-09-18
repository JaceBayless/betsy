Betsy::Engine.routes.draw do
  get "/etsy_response_listener", to: "response_listener#etsy_response_listener"
end
