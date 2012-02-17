module Mhq
  class DbIndex < Base
    default_task :list

    desc "list", "list indexes for database"
    method_option :db, :required => true
    def list
      auth_me
      raise MongoHQ::Index.all(options.db, collection_name).inspect
    end

  end
end