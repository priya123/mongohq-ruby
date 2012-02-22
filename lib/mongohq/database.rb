# TODO: use command pattern to build an enumerable
# command that's not called until it's used
module MongoHQ
  class Database < Base

    class DbNotFound < RuntimeError; end

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
      rescue Kernel::InternalServerError
        raise DbNotFound
      end

      def create(params)
        Database.new(client.post('/databases', params))
      end

      def delete(database_name)
        client.delete("/databases/#{database_name}")
      end
    end

    def collections
      Collection.new(:database => self)
    end

    def stats
      DatabaseStats.find(self)
    end

    def logs
      DatabaseLogs.find(self)
    end

    def users
      User.all(self.name)
    end

    def add_user(user, password)
      User.create(self.name, user, password)
    end

    def remove_user(user)
      User.delete(self.name, user)
    end

    def deployment_path
      path = self.hostname.gsub(/[^\.]+[0-9]+\./, "")
      "#{path}:#{port}"
    end

    def to_url
      "mongo://#{hostname}:#{port}/#{name}"
    end

    def to_s
      "#{name} on #{hostname}"
    end
  end
end
