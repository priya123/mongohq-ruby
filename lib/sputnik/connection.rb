module Sputnik
  DEFAULT_HOST = 'https://api.mongohq.com'
  
  %w{MissingApikeyError InvalidApikeyError InternalServerError NotImplementedError NotFoundError}.each{|const|
    Kernel.const_set const, Class.new(RuntimeError)
  }

  class Connection
    attr_reader :apikey, :base_url

    def initialize(options={})
      @apikey = options[:apikey]
      @base_url = options[:base_url] || DEFAULT_HOST
    end

    def connect
      conn = Faraday.new(:url => base_url) do |builder|
        builder.request :json
        builder.adapter :net_http
      end
      conn
    end

    def get(path, params={})
      params = params.merge({:_apikey => apikey})
      response = connect.get do |req|
        req.url(path)
        req.headers['User-Agent'] = default_header
        req.params = params
      end

      verify_status!(response)

      return JSON.parse(response.body) || {}
    end

    def post(path, params={})
      params = params.merge({:_apikey => apikey})
      response = connect.post do |req|
        req.url(path)
        req.params = params
        req.headers['Content-Type'] = 'application/json'
        req.headers['User-Agent'] = default_header
      end

      verify_status!(response)

      return JSON.parse(response.body) || {}
    end

    def default_header
      "Sputnik/#{VERSION}/ruby"
    end

  private

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
