require 'spec_helper'
require 'mongohq'
require 'fakeweb'

describe MongoHQ::Authenticate do
  describe "get session" do

    context "with proper creditials" do
      it "raises an error" do
        FakeWeb.clean_registry
        FakeWeb.register_uri(:get, "https://auth.mongohq.com/simple?username=myemail%40example.com&password=wrong",
          :body => "{\"error\":\"Unauthorized\"}",
          :status => "401"
        )
        lambda { MongoHQ::Authenticate.get_apikey('myemail@example.com', 'wrong') }.should raise_exception(MongoHQ::AuthenticationError)
      end
    end

    context "with improper creditials" do
      it "is successful" do
        FakeWeb.register_uri(:get, "https://auth.mongohq.com/simple?username=myemail%40example.com&password=sekret",
                             :body => "{\"instance_url\":\"https://api.mongohq.com\",\"issued_at\":\"2012-02-07T01:20:45+00:00\",\"access_token\":\"my_api_key\"}",
                             :status => "200"
        )
        api_key = MongoHQ::Authenticate.get_apikey('myemail@example.com', 'sekret')
        api_key.should == "my_api_key"
      end
    end
  end
end
