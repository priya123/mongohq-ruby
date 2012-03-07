module Mhq
  class Index < Base
    default_task :list

    namespace :indexes

    desc "list", "list indexes for database"
    method_option :db, :required => true
    method_option :collection
    def list
      auth_me
      indexes = []

      collections = options.collection ? [MongoHQ::Collection.find(options.db, options.collection)] : MongoHQ::Collection.all(options.db)

      collections.each do |collection|
        MongoHQ::Index.all(options.db, collection.name).each do |index|
          indexes << {:collection => collection.name, :key => index.key, :unique => index.unique || ""}
        end
      end

      table indexes.flatten, :fields => [:collection, :key, :unique]
    end

  end
end