module Sputnik
  class Index < Base
    class << self
      def all(database_name, collection_name)
        response = client.get("/databases/#{database_name}/collections/#{collection_name}/indexes")
        values = []
        response.each do |item|
          values << Index.new(item)
        end
      end

      def find(database_name, collection_name, index_name)
        Index.new(client.get("/databases/#{database_name}/collections/#{collection_name}/indexes/#{index_name}"))
      end

      def create(database_name, collection_name, params)
        Index.new(client.post("/databases/#{database_name}/collections/#{collection_name}/indexes", params))
      end

      def delete(database_name, collection_name, index_name)
        client.delete("/databases/#{database_name}/collections/#{collection_name}/indexes/#{index_name}", params)
      end
    end
  end
end
