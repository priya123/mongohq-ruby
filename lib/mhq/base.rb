module Mhq
  class Base < Thor
    include Hirb::Console
    include Mhq::Helpers

    no_tasks {
      def auth_me
        MongoHQ.authenticate(Mhq::AuthStorage.new.retrieve)
      end
    }
  end
end