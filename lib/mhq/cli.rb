require 'thor'
require 'thor/group'
require 'mhq'
require 'time'

module Mhq
  class CLI < Thor
    register(Database, 'dbs', 'dbs <command>', 'manage dbs (show, create, destroy)')
    register(DbAuth, 'dbauth', 'dbauth <command>', 'manage database users (list, create, destroy)')
    register(DbIndex, 'indexes', 'indexes <command>', 'manage indexes (list, create, destroy)')
    register(Plan, 'plans', 'plans', 'list available mongohq plans')
    register(Log, 'logs', 'logs', 'logs for your database')
    register(Stats, 'stats', 'stats', 'stats for your database')
  end
end