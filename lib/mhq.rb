require "rubygems"
require "faraday"
require "mongohq"
require "hirb"

module Mhq
  autoload :AuthStorage, File.dirname(__FILE__) + "/mhq/auth_storage.rb"
  autoload :Base, File.dirname(__FILE__) + "/mhq/base.rb"
  autoload :Database, File.dirname(__FILE__) + "/mhq/database.rb"
  autoload :User, File.dirname(__FILE__) + "/mhq/user.rb"
  autoload :Index, File.dirname(__FILE__) + "/mhq/index.rb"
  autoload :Log, File.dirname(__FILE__) + "/mhq/log.rb"
  autoload :Plan, File.dirname(__FILE__) + "/mhq/plan.rb"
  autoload :Stats, File.dirname(__FILE__) + "/mhq/stats.rb"
  autoload :Helpers, File.dirname(__FILE__) + "/mhq/helpers.rb"
end
