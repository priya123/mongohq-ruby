module MongoHQ
  class User < Base
    class << self
      def all(database_name)
        response = client.get("/databases/#{database_name}/users")
        values = []
        response.each do |item|
          values << User.new(item)
        end
        values
      end

      def find(database_name, user)
        User.new(client.get("/databases/#{database_name}/users/#{user}"))
      end

      def create(database_name, user, password)
        User.new(client.post("/databases/#{database_name}/users", :user => user, :password => password))
      end

      def delete(database_name, user)
        User.new(client.delete("/databases/#{database_name}/users/#{user}"))
      end
    end

    def all(params=nil)
      User.all(collection.database.db, collection.name, params || self.to_hash)
    end

    def find(name=nil, params=nil)
      User.find(collection.database.db, collection.name, name || self.name, params || self.to_hash)
    end

    def create(params=nil)
      User.create(collection.database.db, collection.name, params || self.to_hash)
    end

    def delete(name=nil)
      User.delete(collection.database.db, collection.name, name || self.name)
    end
  end
end
