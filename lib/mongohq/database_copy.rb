module MongoHQ

  class DatabaseCopy < Base
    class InvalidArguments < RuntimeError; end

    class << self

      def run(args)
        raise InvalidArguments if args[:from].nil? || args[:to].nil?

        to = args[:to].is_a?(Database) ? args[:to].name : to
        from = args[:from].is_a?(Database) ? args[:from].name : from

        DatabaseCopy.new(client.post('/copy_database', {:from => from, :to => to}))
      end

    end

  end

end