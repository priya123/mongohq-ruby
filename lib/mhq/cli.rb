require 'thor'
require 'thor/group'
require 'mhq'

module Mhq
  class CLI < Base
    register(Database, 'dbs', 'dbs <command>', 'manage dbs (show, create, destroy)')
    register(Plan, 'plans', 'plans', 'list available mongohq plans')

    desc "stats <database name>", "Show stats for database"
    method_option :tail, :aliases => "-f", :desc => "Tail stats continuously.", :type => :boolean
    method_option :host, :aliases => "-h", :desc => "Hostname to restrict", :type => :string
    def stats(database_name)
      auth_me
      Mhq::Stats.new.show(database_name, options.host, options.tail)
    end

  end
end