require 'rubygems'
require 'thor'
require 'thor/group'
require 'mhq'
require 'time'

module Mhq
  class CLI < Thor
    register(Database, 'dbs', 'dbs <command>', 'manage dbs (create, destroy, help, show)')
    register(User, 'users', 'user <command>', 'manage database users (create, destroy, help, list)')
    register(Index, 'indexes', 'indexes <command>', 'manage indexes (create, destroy, help, list)')
    register(Plan, 'plans', 'plans', 'list available mongohq plans')
    register(Log, 'logs', 'logs', 'logs for your database (help)')
    register(Stats, 'stats', 'stats', 'stats for your database (help)')
  end
end
