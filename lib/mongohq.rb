require 'mongohq/version'
require 'ostruct'
require 'json'
require 'faraday'
require 'mongohq/connection'

module MongoHQ
  ConnectionNotAuthenticatedError = Class.new(RuntimeError)
  AuthenticationError = Class.new(RuntimeError)

  class << self
    def authenticate(options={})
      MongoHQ.client = MongoHQ::Connection.new(options)
    end

    def client
      Thread.current[:mongohq_client] || (raise ConnectionNotAuthenticatedError, 'You must first call the authenticate method to connect to MongoHQ.')
    end

    def client=(new_client)
      Thread.current[:mongohq_client] = new_client
    end
  end
end

require 'mongohq/base'
require 'mongohq/authenticate'
require 'mongohq/plan'
require 'mongohq/database'
require 'mongohq/stat_member'
require 'mongohq/database_stats'
require 'mongohq/database_logs'
require 'mongohq/database_users'
require 'mongohq/collection'
require 'mongohq/document'
require 'mongohq/index'
