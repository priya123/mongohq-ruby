require 'thor'
require 'thor/group'
require 'mhq'
require 'time'

module Mhq
  class CLI < Base
    register(Database, 'dbs', 'dbs <command>', 'manage dbs (show, create, destroy)')
    register(DbAuth, 'dbauth', 'dbauth <command>', 'manage database users (list, create, destroy)')
    register(DbIndex, 'indexes', 'indexes <command>', 'manage indexes (list, create, destroy)')
    register(Plan, 'plans', 'plans', 'list available mongohq plans')

    desc "stats <database name>", "Show stats for database"
    method_option :tail, :aliases => "-f", :desc => "Tail stats continuously.", :type => :boolean
    method_option :host, :aliases => "-h", :desc => "Hostname to restrict", :type => :string
    def stats(database_name)
      auth_me
      Mhq::Stats.new.show(database_name, options.host, options.tail)
    end

    desc "logs <database name>", "Show logs for database"
    method_option :host, :aliases => "-h", :desc => "Hostname to restrict", :type => :string
    def logs(database_name)
      auth_me
      Mhq::Log.new.show(database_name, options.host)
    end

  end
end