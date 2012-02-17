module MongoHQ
  class DatabaseLogs < Base
    attr_accessor :members

    class << self
      def find(db_name)
        if db_name.is_a?(MongoHQ::Database)
          db = db_name
        else
          db = MongoHQ::Database.find(db_name)
        end

        response = client.get("/deployments/#{db.deployment_path}/logs")

        logs = DatabaseLogs.new
        logs.members = []
        response.each do |member|
          logs.members << StatMember.new(:host => member["member"], :log => member["log"])
        end
        logs
      end
    end


  end
end
