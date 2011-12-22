require 'spec_helper'
require 'mongohq'

describe MongoHQ::Connection do
  describe "authentication" do
    it "raises an error when uninitialized" do
      lambda { MongoHQ.client }.should raise_exception(MongoHQ::ConnectionNotAuthenticatedError)
    end
    it "no error when initialized" do
      MongoHQ.authenticate(:apikey => 'derp')
      lambda { MongoHQ.client }.should_not raise_exception(MongoHQ::ConnectionNotAuthenticatedError)
    end
  end

  describe "client" do
    before do
      MongoHQ.authenticate(:apikey => 'derp')
    end
    [[403, ForbiddenError],
     [404, NotFoundError],
     [500, InternalServerError],
     [501, NotImplementedError]
    ].each do |code, err|
      it "verify #{code} error" do
        response = Struct.new(:status, :body).new(code, '{"error" : "Error Message"}')
        MongoHQ.client.stub_chain(:connect, :get).and_return(response)
        lambda { MongoHQ.client.get('/') }.should raise_exception(err)
      end
    end
  end
end
