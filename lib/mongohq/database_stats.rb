module MongoHQ
  class DatabaseStats < Base
    attr_accessor :members

    class << self
      def find(database_name)
        response = client.get("/databases/#{database_name}/stats")
        members = response.delete("members")
        stats = DatabaseStats.new(response)
        stats.members = members.map { |m| Member.new(m) }
        stats
      end
    end
  end
end
