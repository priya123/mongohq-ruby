module Sputnik
  class Plan < Base
    class << self
      def all
        response = client.get('/plans')
        values = []
        response.each do |item|
          values << Plan.new(item)
        end
      end
    end
  end
end
