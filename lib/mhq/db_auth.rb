module Mhq
  class DbAuth < Base
    default_task :list

    namespace :dbauth

    desc "list", "list database users"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def list
      auth_me
      table MongoHQ::Database.find(options.db).users, :fields => [:user, :readOnly]
    end

    desc "create", "create database user"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def create
      auth_me
      table MongoHQ::Database.find(options.db).users, :fields => [:user, :readOnly]
    end

    desc "update", "update database user"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def update
      auth_me
      table MongoHQ::Database.find(options.db).users, :fields => [:user, :readOnly]
    end

    desc "create", "create database user"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def destroy
      auth_me
      table MongoHQ::Database.find(options.db).users, :fields => [:user, :readOnly]
    end

  end
end