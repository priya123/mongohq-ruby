module Sputnik
  class Database < Base
    def collection
      raise "Not Yet Implemented"
      # TODO: call this database's collection
      # for example, to get a database's collections:
      # Sputnik::Database.new(:name => 'derp').collection.all
    end

    class << self
      def all
        response = client.get('/databases')
        values = []
        response.each do |item|
          values << Database.new(item)
        end
      end

      def find(database_name)
        Database.new(client.get("/databases/#{database_name}"))
      end

      def create(params)
        Database.new(client.post('/databases', params))
      end

      def delete(database_name)
        client.delete("/databases/#{database_name}", params)
      end
    end
  end
end
