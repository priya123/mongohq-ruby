module Sputnik
  class DatabaseStats < Base
    class << self
      def find(database_name)
        DatabaseStats.new(client.get("/databases/#{database_name}/stats"))
      end
    end
  end
end
