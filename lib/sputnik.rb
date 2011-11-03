require "sputnik/version"
require "sputnik/connection"
require "sputnik/base"
require "sputnik/database"

module Sputnik
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
