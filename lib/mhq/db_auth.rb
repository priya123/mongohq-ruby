module Mhq
  class DbAuth < Thor
    default_task :list

    desc "list <database name>", "list database users"
    def list(db_name)
      table MongoHQ::Database.users, :fields => [:name]
    end

  end
end