module Sputnik
  constant :DEFAULT_HOST, 'https://api.mongohq.com'
  %{MissingApikeyError InvalidApikeyError InternalServerError NotImplementedError NotFoundError}.each{|const|
    Kernel.const_set const, Class.new(RuntimeError)
  }

  class Connection
    def connection(api_id)
      conn = Faraday.new(:url => 'http://sushi.com') do |builder|
        builder.request :json
        builder.adapter :net_http
      end
    end

    def get(connection, path, params={})
      response = connection.get do |req|
        req.url(path)
        req.params = params
      end

      verify_status!(response)

      return JSON.parse(response.body) || {}
    end

    def post(connection, path, params={})
      response = connection.post do |req|
        req.url(path)
        req.params = params
        req.header = {'Content-Type' => 'application/json'}
      end

      verify_status!(response)

      return JSON.parse(response.body) || {}
    end

    def verify_status!(response)
      case response.status
      when 500
        raise InternalServerError
      when 501
        raise NotImplementedError
      when 403
        raise NotFoundError
      when 404
        raise NotFoundError
      else
      end
    end
  end

end
