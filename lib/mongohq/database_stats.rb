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

        response = client.get("/deployments/#{db.deployment_path}/stats").first
        members = response.delete("members")
        stats = DatabaseStats.new(response)
        stats.members = members.map { |m| StatMember.new(m) }
        stats
      end
    end
  end
end
