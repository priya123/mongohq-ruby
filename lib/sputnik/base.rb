module Sputnik
  class Base < OpenStruct
    def self.client
      Sputnik.client
    end
  end
end
