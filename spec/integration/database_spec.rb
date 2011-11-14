require 'spec_helper'
require 'sputnik'

describe Sputnik::Database do
  describe "action" do
    before do
      Sputnik.authenticate(:apikey => 'derp')
    end

    it "all" do
      Sputnik.client.stub!(:get).and_return([{:db => 'cigars'}])
      databases = Sputnik::Database.all
      databases.should_not be_empty
      databases.first.db.should == 'cigars'
    end

    it "find" do
      Sputnik.client.stub!(:get).and_return({:db => 'cigars'})
      database = Sputnik::Database.find('cigars')
      database.db.should == 'cigars'
    end

    it "create" do
      Sputnik.client.stub!(:post).and_return({:db => 'cigars'})
      database = Sputnik::Database.create('cigars')
      database.db.should == 'cigars'
    end

    it "delete" do
      Sputnik.client.stub!(:delete)
      Sputnik::Database.delete('cigars')
    end
  end

  # Sputnik::Database.new(:name => 'derp').collection.all
end
