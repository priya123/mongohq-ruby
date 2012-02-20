module Mhq
  class Plan < Base
    default_task :list

    namespace :plan

    desc "list", "List of MongoHQ plans"
    def list
      auth_me
      table MongoHQ::Plan.all.sort_by(&:price).reverse, :fields => [:slug, :name, :price, :type]
    end

  end
end