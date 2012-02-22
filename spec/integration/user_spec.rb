require 'spec_helper'

describe MongoHQ::User do

  it "it should return all users" do
    FakeWeb.register_uri(:get, "https://api.mongohq.com/databases/my_database/users?_apikey=sekret",
                         :status => "200",
                         :body => '[{"user": "john"}]')
    MongoHQ.authenticate(:apikey => "sekret")
    users    = MongoHQ::User.all("my_database")

    users.count.should == 1
    users.first.user.should == 'john'
  end

  it "it should create a new user" do
    FakeWeb.register_uri(:post, "https://api.mongohq.com/databases/my_database/users?_apikey=sekret&user=new_user&password=sekret",
                         :status => "200",
                         :body => '{"ok": 1}')
    MongoHQ.authenticate(:apikey => "sekret")
    response = MongoHQ::User.create("my_database", "new_user", "sekret")

    response.ok.should == 1
  end

  it "it should delete a user" do
    FakeWeb.register_uri(:delete, "https://api.mongohq.com/databases/my_database/users/new_user?_apikey=sekret",
                         :status => "200",
                         :body => '{"ok": 1}')
    MongoHQ.authenticate(:apikey => "sekret")
    response = MongoHQ::User.delete("my_database", "new_user")

    response.ok.should == 1
  end

end
