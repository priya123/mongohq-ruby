module MongoHQ
  class DatabaseStats < Base
    attr_accessor :members

    class << self
      def find(db_name)
        if db_name.is_a?(MongoHQ::Database)
          db = db_name
        else
          db = MongoHQ::Database.find(db_name)
        end

        response = client.get("/deployment/#{db.stats_path}/stats")
        members = response.delete("members")
        stats = DatabaseStats.new(response)
        stats.members = members.map { |m| Member.new(m) }
        stats
      end
    end
  end
end
