# TODO: this has room to be considerably cooler...
module Sputnik
  class Document < Base
    class << self
      def all(database_name, collection_name)
        response = client.get("/databases/#{database_name}/collections/#{collection_name}/documents")
        values = []
        response.each do |item|
          values << Document.new(item)
        end
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
        client.delete("/databases/#{database_name}/collections/#{collection_name}/documents/#{document_id}", params)
      end
    end
  end
end
