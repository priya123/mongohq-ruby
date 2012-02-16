module Mhq
  class Database < Base

    def show(db_name)
      db = MongoHQ::Database.find(db_name)
      fields = [:name, :plan, :to_url, :ok, :objects, :avgObjSize, :storageSize, :dataSize, :fileSize, :indexes, :indexSize, :nsSizeMB, :numExtents]
      table db, :vertical => true, :fields => fields
    end

    def all
      table MongoHQ::Database.all.sort_by(&:name), :fields => [:name, :plan]
    end

  end
end