require 'spec_helper'
require 'mongohq'

describe MongoHQ::DatabaseCopy do

  describe "action" do
    it "should copy an empty database" do
      FakeWeb.register_uri(:post, "https://api.mongohq.com/copy_database?from&to=other_database&_apikey=sekret",
                           :status => "200",
                           :body => "{\"copy\": true, \"from\": \"my_database\", \"to\": \"other_database\"}")
      MongoHQ.authenticate(:apikey => "sekret")

      database_copy = MongoHQ::Database.new({"name" => "other_database"}).copy(:from => "my_database")

      database_copy.copy.should == true
    end

    it "should fail on non-empty database" do
      FakeWeb.register_uri(:post, "https://api.mongohq.com/copy_database?from&to=other_database&_apikey=sekret",
                           :status => "200",
                           :body => "{\"copy\": false, \"from\": \"my_database\", \"to\": \"other_database\", \"error\": \"Destination database is not empty.\"}")
      MongoHQ.authenticate(:apikey => "sekret")

      database_copy = MongoHQ::Database.new({"name" => "other_database"}).copy(:from => "my_database")

      database_copy.copy.should == false
      database_copy.error.should == "Destination database is not empty."
    end
  end

end


