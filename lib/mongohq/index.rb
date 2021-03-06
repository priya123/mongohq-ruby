module MongoHQ
  class Index < Base
    class << self
      def all(database_name, collection_name)
        response = client.get("/databases/#{database_name}/collections/#{collection_name}/indexes")
        values = []
        response.each do |item|
          values << Index.new(item)
        end
        values
      end

      def find(database_name, collection_name, index_name)
        Index.new(client.get("/databases/#{database_name}/collections/#{collection_name}/indexes/#{index_name}"))
      end

      def create(database_name, collection_name, params)
        Index.new(client.post("/databases/#{database_name}/collections/#{collection_name}/indexes", params))
      end

      def delete(database_name, collection_name, index_name)
        client.delete("/databases/#{database_name}/collections/#{collection_name}/indexes/#{index_name}")
      end
    end

    def all(params=nil)
      Index.all(collection.database.db, collection.name, params || self.to_hash)
    end

    def find(name=nil, params=nil)
      Index.find(collection.database.db, collection.name, name || self.name, params || self.to_hash)
    end

    def create(params=nil)
      Index.create(collection.database.db, collection.name, params || self.to_hash)
    end

    def delete(name=nil)
      Index.delete(collection.database.db, collection.name, name || self.name)
    end
  end
end
