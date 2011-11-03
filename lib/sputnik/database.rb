module Sputnik
  # TODO: response objects should wrap results in model objects
  class Database < Base
    def initialize(params)
      @params = params
    end

    class << self
      def all
        client.get('/databases')
      end

      def find(database_name)
        client.get("/databases/#{database_name}")
      end

      def create(params)
        client.post('/databases', params)
      end

      def delete(database_name)
        client.post("/databases/#{database_name}", params)
      end
    end
  end
end

# Sputnik.authenticate(:apikey => 'derp', :base_url => 'http://localhost:9000')
# 
# databases = Sputnik::Database.all
# database =  Sputnik::Database.find('joemo')
# Sputnik::Database.create({'my new derp'})
# Sputnik::Database.delete('joemo')

# Struct.new(:all, :count, :total_count).new(response['items'], response['filtered'], response['total'])
