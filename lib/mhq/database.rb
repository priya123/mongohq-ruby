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

      response = MongoHQ::Database.create(:slug => plan_slug, :name => name)

      if response.ok
        Mhq::Database.new.show(name)
      else
        say response.error
      end
    end

    def all
      table MongoHQ::Database.all.sort_by(&:name), :fields => [:name, :plan]
    end

  end
end