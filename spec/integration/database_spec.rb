require 'spec_helper'
require 'mongohq'

describe MongoHQ::Database do
  describe "action" do
    before do
      MongoHQ.authenticate(:apikey => 'derp')
    end

    it "all" do
      MongoHQ.client.stub!(:get).and_return([{:db => 'cigars'}])
      databases = MongoHQ::Database.all
      databases.should_not be_empty
      databases.first.db.should == 'cigars'
    end

    it "find" do
      MongoHQ.client.stub!(:get).and_return({:db => 'cigars'})
      database = MongoHQ::Database.find('cigars')
      database.db.should == 'cigars'
    end

    it "create" do
      MongoHQ.client.stub!(:post).and_return({:db => 'cigars'})
      database = MongoHQ::Database.create('cigars')
      database.db.should == 'cigars'
    end

    it "delete" do
      MongoHQ.client.stub!(:delete)
      MongoHQ::Database.delete('cigars')
    end

    # MongoHQ::Database.new(:name => 'derp').collection.all
  end
end
