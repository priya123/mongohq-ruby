module MongoHQ
  class DatabaseUsers < Base
    attr_accessor :users

    class << self
      def find(db_name)
        if db_name.is_a?(MongoHQ::Database)
          db = db_name
        else
          db = MongoHQ::Database.find(db_name)
        end

        response = client.get("/databases/#{db.name}/collections/system.users/documents")
        response.map { |u| DatabaseUsers.new(u) }
      end
    end
  end
end
