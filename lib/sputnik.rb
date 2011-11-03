require 'sputnik/version'
require 'ostruct'
require 'json'
require 'faraday'
require 'sputnik/connection'

module Sputnik
  class << self
    def authenticate(options={})
      Sputnik.client = Sputnik::Connection.new(options)
    end

    def client
      Thread.current[:sputnik_client]
    end

    def client=(new_client)
      Thread.current[:sputnik_client] = new_client
    end
  end
end

require 'sputnik/base'
require 'sputnik/plan'
require 'sputnik/database'
require 'sputnik/database_stats'
require 'sputnik/collection'
require 'sputnik/document'
require 'sputnik/index'
