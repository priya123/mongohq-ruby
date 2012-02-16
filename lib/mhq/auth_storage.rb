require 'yaml'
require 'highline'

module Mhq
  class AuthStorage < Base
    def auth(email = nil, password = nil)
      email ||= ask("email: ")
      password ||= HighLine.new.ask("password:  ") { |q| q.echo = "*" }

      if api_key = MongoHQ::Authenticate.get_apikey(email, password)
        store(email, api_key)
        {:apikey => api_key}
      end
    rescue MongoHQ::AuthenticationError
      say "Could not find account with given email and password"
      exit
    end

    def store(email, api_key)
      Dir.mkdir(config_dir) unless Dir.exists?(config_dir)
      config = {email: email, apikey: api_key}
      File.open(config_file, 'w') { |f| f.write(config.to_yaml) }
    end

    def retrieve
      if File.exists?(config_file)
        YAML::load(File.read(config_file))
      else
        say "Please authenticate"
        auth
      end
    end

    def config_dir
      @config_dir ||= File.join(ENV["HOME"], ".mongohq")
    end

    def config_file
      @config_file ||= File.join(config_dir, "credentials")
    end
  end
end