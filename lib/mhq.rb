require "rubygems"
require "faraday"
require "mongohq"
require "hirb"

module Mhq
  autoload :AuthStorage, File.dirname(__FILE__) + "/mhq/auth_storage.rb"
  autoload :Base, File.dirname(__FILE__) + "/mhq/base.rb"
  autoload :Database, File.dirname(__FILE__) + "/mhq/database.rb"
  autoload :DbAuth, File.dirname(__FILE__) + "/mhq/db_auth.rb"
  autoload :DbIndex, File.dirname(__FILE__) + "/mhq/db_index.rb"
  autoload :Log, File.dirname(__FILE__) + "/mhq/log.rb"
  autoload :Plan, File.dirname(__FILE__) + "/mhq/plan.rb"
  autoload :Stats, File.dirname(__FILE__) + "/mhq/stats.rb"
  autoload :Helpers, File.dirname(__FILE__) + "/mhq/helpers.rb"
end
