module Betsy
  class Engine < ::Rails::Engine
    isolate_namespace Betsy

    initializer "" do |app|
      app.routes.prepend do
        mount Betsy::Engine => "/"
      end
    end
  end
end
