module MongoHQ
  class Plan < Base
    class << self
      def all
        response = client.get('/plans')
        values = []
        response.each do |item|
          values << Plan.new(item)
        end
        values
      end
    end
  end
end
