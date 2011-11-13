# TODO: use command pattern to build an enumerable
# command that's not called until it's used
module Sputnik
  class Database < Base
    class << self
      def all
        response = client.get('/databases')
        values = []
        response.each do |item|
          values << Database.new(item)
        end
        values
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

    # Sputnik::Database.new(:name => 'derp').collection.all
    def collections
      Collection.new(:database => self)
    end

    def stats
      DatabaseStats.find(db)
    end
  end
end
