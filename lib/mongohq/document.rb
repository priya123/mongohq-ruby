module MongoHQ
  class Document < Base
    class << self
      def all(database_name, collection_name, params={})
        response = client.get("/databases/#{database_name}/collections/#{collection_name}/documents", params)
        values = []
        response.each do |item|
          values << Document.new(item)
        end
        values
      end

      def find(database_name, collection_name, document_id)
        Document.new(client.get("/databases/#{database_name}/collections/#{collection_name}/documents/#{document_id}"))
      end

      def create(database_name, collection_name, params)
        Document.new(client.post("/databases/#{database_name}/collections/#{collection_name}/documents", params))
      end

      def update(database_name, collection_name, document_id, params)
        Document.new(client.put("/databases/#{database_name}/collections#{collection_name}/documents/#{document_id}", params))
      end

      # TODO: how about a "save" option? I could add it here, but it would be two server hits

      def delete(database_name, collection_name, document_id)
        client.delete("/databases/#{database_name}/collections/#{collection_name}/documents/#{document_id}")
      end
    end

    def all(params=nil)
      Document.all(collection.database.db, collection.name, params || self.to_hash)
    end

    def find(id=nil, params=nil)
      Document.find(collection.database.db, collection.name, id || self._id, params || self.to_hash)
    end

    def create(params=nil)
      Document.create(collection.database.db, collection.name, params || self.to_hash)
    end

    def update(id=nil, params=nil)
      Document.update(collection.database.db, collection.name, id || self._id, params || self.to_hash)
    end

    def delete(id=nil)
      Document.delete(collection.database.db, collection.name, id || self._id)
    end
  end
end
