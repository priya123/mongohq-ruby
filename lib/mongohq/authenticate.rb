module MongoHQ
  class Authenticate < Base
    DEFAULT_HOST = "https://auth.mongohq.com"

    class << self
      def get_apikey(username, password, options = {})
        conn = Faraday.new(:url => options[:base_url] || DEFAULT_HOST) do |builder|
          builder.request :json
          builder.adapter :net_http
        end

        response = conn.get do |req|
          req.url("/simple")
          req.headers['User-Agent'] = MongoHQ::Connection.default_header
          req.params = {:username => username, :password => password}
        end

        if response.status == 200
          JSON.parse(response.body)["access_token"]
        else
          raise MongoHQ::AuthenticationError, "incorrect email and password supplied"
        end
      end
    end
  end
end
