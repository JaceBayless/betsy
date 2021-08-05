module Betsy
  module Model
    module ClassMethods
      BASE_ETSY_API_URL = "https://openapi.etsy.com"

      def attribute(name)
        define_method name do
          @result[name.to_s]
        end
      end

      def make_request(request_type, endpoint, options = {})
        check_token_expiration(options[:etsy_account]) if options[:etsy_account]
        headers = access_credentials(options[:etsy_account])
        options.delete(:etsy_account)
        response = JSON.parse(Faraday.method(request_type).call("#{BASE_ETSY_API_URL}#{endpoint}", options, headers).body)
        handle_response(response)
      end

      def check_token_expiration(etsy_account)
        if etsy_account.last_token_refresh + etsy_account.expires_in <= DateTime.now
          options = {
            grant_type: "refresh_token",
            refresh_token: etsy_account.refresh_token,
            client_id: Betsy.api_key
          }
          response = JSON.parse(Faraday.post("https://api.etsy.com/v3/public/oauth/token", options).body)
          etsy_account.access_token = response["access_token"]
          etsy_account.expires_in = response["expires_in"]
          etsy_account.refresh_token = response["refresh_token"]
          etsy_account.last_token_refresh = DateTime.now
          etsy_account.save
        end
      end

      def access_credentials(etsy_account)
        header = {x_api_key: Betsy.api_key}
        header[:Authorization] = "Bearer #{etsy_account.access_token}" if etsy_account.present?
        header
      end

      def handle_response(response)
        objects = nil
        if response["count"].nil?
          objects = new(response)
        else
          objects = []
          response["results"].each do |data|
            objects.append(new(data))
          end
        end
        objects
      end
    end

    def initialize(data = nil)
      @result = data
    end

    def self.included(other)
      other.extend(ClassMethods)
    end
  end
end
