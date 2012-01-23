require File.join(File.dirname(__FILE__), 'mongohq/version')
require 'ostruct'
require 'json'
require 'faraday'
require File.join(File.dirname(__FILE__), 'mongohq/connection')

module MongoHQ
  ConnectionNotAuthenticatedError = Class.new(RuntimeError)

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

require File.join(File.dirname(__FILE__), 'mongohq/base')
require File.join(File.dirname(__FILE__), 'mongohq/plan')
require File.join(File.dirname(__FILE__), 'mongohq/database')
require File.join(File.dirname(__FILE__), 'mongohq/database_stats')
require File.join(File.dirname(__FILE__), 'mongohq/collection')
require File.join(File.dirname(__FILE__), 'mongohq/document')
require File.join(File.dirname(__FILE__), 'mongohq/index')
