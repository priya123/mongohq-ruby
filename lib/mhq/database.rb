module Mhq
  class Database < Base
    default_task :list

    desc "show", "More information on database"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def show
      auth_me
      db = MongoHQ::Database.find(options.db)
      table db, :vertical => true, :fields => [:name, :plan, :to_url, :ok, :objects, :avgObjSize, :storageSize, :dataSize, :fileSize, :indexes, :indexSize, :nsSizeMB, :numExtents]
    rescue Kernel::InternalServerError
      say "Could not find database named #{options.db}"
      exit
    end

    desc "collections [database]", "List collections"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def collections
      auth_me
      table MongoHQ::Collection.all(options.db).sort_by(&:name).map { |collection|
        {name: collection.name, count: collection.count, storageSize: human_size(collection.storageSize), avgObjSize: human_size(collection.avgObjSize), indexCount: collection.indexCount}
      }, :fields => [:name, :count, :storageSize, :avgObjSize, :indexCount]
    end

    desc "create", "Deploy a new database"
    method_option :name, :aliases => '-n'
    method_option :plan_slug, :aliases => '-p'
    def create
      auth_me
      plan_slug = options.plan_slug || menu(MongoHQ::Plan.all.sort_by(&:price).reverse, :fields => [:slug, :name, :price, :type], :directions => false, :prompt => "Plan Size? ").first.slug
      name      = options.name || ask("Database Name: ")

      plan_slug = plan_slug.downcase
      available_plans =  MongoHQ::Plan.all.map(&:slug)

      errors = []

      errors << "  Database name must be alphanumeric with underscores, i.e. =~ /^[A-z0-9\_]+$/" unless name =~ /^[A-z0-9\_]+$/
      errors << "  Plan must be one of:\n#{available_plans.map {|p| "   - #{p}" }.join("\n")}" unless available_plans.include?(plan_slug)

      say("Errors:") && errors.map { |e| say(e) } && exit unless errors.empty?

      response = MongoHQ::Database.create(:slug => plan_slug, :name => name)

      if response.ok
        Mhq::Database.new.show(name)
      else
        say response.error
      end
    end

    desc "destroy [database name]", "Delete a database"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    def destroy
      auth_me
      confirmation = ask("To delete, please type in the full name of the database:")

      if name === confirmation && MongoHQ::Database.delete(options.db)
        say("Database #{options.db} has been deleted.")
      else
        say("Confirmation did not match original request -- database was not deleted.")
      end
    end

    desc "list", "List all of my databases"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string
    def list
      auth_me
      table MongoHQ::Database.all.sort_by(&:name), :fields => [:name, :plan]
    end
  end
end