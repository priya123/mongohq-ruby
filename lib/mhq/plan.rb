module Mhq
  class Plan < Base

    def all
      table MongoHQ::Plan.all.sort_by(&:price).reverse, :fields => [:slug, :name, :price, :type]
    end

  end
end