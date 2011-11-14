module Sputnik
  class Collection < Base
    class << self
      def all(database_name)
        response = client.get("/databases/#{database_name}/collections")
        values = []
        response.each do |item|
          values << Collection.new({col: item})
        end
        values
      end

      def find(database_name, collection_name)
        Collection.new(client.get("/databases/#{database_name}/collections/#{collection_name}"))
      end

      def create(database_name, params)
        Collection.new(client.post("/databases/#{database_name}/collections", params))
      end

      def update(database_name, collection_name, params)
        Collection.new(client.put("/databases/#{database_name}/collections/#{collection_name}", params))
      end

      # TODO: how about a "save" option? I could add it here, but it would be two server hits

      def delete(database_name, collection_name)
        client.delete("/databases/#{database_name}/collections/#{collection_name}")
      end
    end

    def all
      Collection.all(database.db)
    end

    def find(collection_name=nil)
      Collection.find(database.db, collection_name || self.name)
    end

    def create(params=nil)
      Collection.create(database.db, params || self.to_hash)
    end

    def update(params=nil)
      Collection.update(database.db, self.name, params || self.to_hash)
    end

    def delete(collection_name=nil)
      Collection.delete(database.db, collection_name || self.name)
    end


    def documents
      Document.new(:database => self.database, :collection => self)
    end

    def indexes
      Index.new(:database => self.database, :collection => self)
    end
  end
end
