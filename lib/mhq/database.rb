module Mhq
  class Database < Base

    def show(db_name)
      db = MongoHQ::Database.find(db_name)
      fields = [:name, :plan, :to_url, :ok, :objects, :avgObjSize, :storageSize, :dataSize, :fileSize, :indexes, :indexSize, :nsSizeMB, :numExtents]
      table db, :vertical => true, :fields => fields
    end

    def create(plan_slug, name)
      plan_slug ||= menu(MongoHQ::Plan.all.sort_by(&:price).reverse, :fields => [:slug, :name, :price, :type], :directions => false, :prompt => "Plan Size? ").first.slug
      name      ||= ask("Database Name: ")

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

    def destroy(name)
      confirmation = ask("To delete, please type in the full name of the database:")

      if name === confirmation && MongoHQ::Database.delete(name)
        say("Database #{name} has been deleted.")
      else
        say("Confirmation did not match original request -- database was not deleted.")
      end
    end

    def all
      table MongoHQ::Database.all.sort_by(&:name), :fields => [:name, :plan]
    end

  end
end