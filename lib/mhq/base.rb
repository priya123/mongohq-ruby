module Mhq
  class Base < Thor
    include Hirb::Console
    include Mhq::Helpers

    no_tasks {
      def auth_me
        MongoHQ.authenticate(Mhq::AuthStorage.new.retrieve)
      end

      def self.banner(task, namespace = true, subcommand = false)
        "#{basename} #{task.formatted_usage(self, true, subcommand)}"
      end
    }
  end
end