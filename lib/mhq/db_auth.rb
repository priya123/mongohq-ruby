module Mhq
  class DbAuth < Base
    default_task :list

    desc "list <database name>", "list database users"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def list
      auth_me
      table MongoHQ::Database.find(options.db).users, :fields => [:user, :readOnly]
    end

  end
end