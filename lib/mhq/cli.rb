require 'thor'
require 'mhq'

module Mhq
  class CLI < Thor

    desc "databases [database name]", "List your databases.  To view more information on a database, include a database name"
    def databases(database_name = nil)
      auth_me

      database_name ?
        Mhq::Database.new.show(database_name) : Mhq::Database.new.all
    end

    desc "plans", "List of MongoHQ plans"
    def plans
      auth_me

      Mhq::Plan.new.all
    end

    desc "stats [database name] [hostname]", "Show stats for database"
    method_option :tail, :aliases => "-f", :desc => "Tail stats continuously.", :type => :boolean
    method_option :host, :aliases => "-h", :desc => "Hostname to restrict", :type => :string
    def stats(database_name)
      auth_me
      Mhq::Stats.new.show(database_name, options.host, options.tail)
    end

    desc "authenticate", "Setup your mhq authentication"
    method_option :email, :aliases => '-e'
    method_option :password, :aliases => '-p'
    def authenticate
      Mhq::AuthStorage.new.auth(options.email, options.password)
    rescue MongoHQ::AuthenticationError
      say "Could not find account with given email and password"
    end

    no_tasks {
      def auth_me
        MongoHQ.authenticate(Mhq::AuthStorage.new.retrieve)
      end
    }
  end
end