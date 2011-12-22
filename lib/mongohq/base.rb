module MongoHQ
  class Base < OpenStruct
    def self.client
      MongoHQ.client
    end
  end
end
