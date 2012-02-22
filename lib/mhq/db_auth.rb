module Mhq
  class DbAuth < Base
    default_task :list

    namespace :dbauth

    desc "list", "list database users"
    method_option :db, :desc => "Database name", :type => :string, :required => true
    def list
      auth_me
      table MongoHQ::Database.find(options.db).users, :fields => [:user, :readOnly]
    end

    desc "create", "create database user"
    method_option :db, :desc => "Database name", :type => :string, :required => true
    method_option :user, :desc => "Database user", :type => :string
    method_option :password, :desc => "Database password", :type => :string
    def create
      auth_me

      user = options.user || ask("User:")
      password = options.password || HighLine.new.ask("password:  ") { |q| q.echo = "*" }

      response = MongoHQ::Database.find(options.db).add_user(user, password)
      unless response.ok
        say response.error
      end
    end

    desc "update", "update database user"
    method_option :db, :desc => "Database name", :type => :string, :required => true
    method_option :user, :desc => "Database user", :type => :string, :required => true
    def update
      auth_me
      password = options.password || HighLine.new.ask("password:  ") { |q| q.echo = "*" }

      response = MongoHQ::Database.find(options.db).add_user(options.user, password)
      unless response.ok
        say response.error
      end
    end

    desc "destroy", "destroy database user"
    method_option :db, :desc => "Database name", :type => :string, :required => true
    method_option :user, :desc => "Database user", :type => :string, :required => true
    def destroy
      auth_me

      response = MongoHQ::Database.find(options.db).remove_user(options.user)
      unless response.ok
        say response.error
      end
    end

  end
end