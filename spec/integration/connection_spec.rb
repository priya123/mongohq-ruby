require 'spec_helper'
require 'sputnik'

describe Sputnik::Connection do
  describe "authentication" do
    it "raises an error when uninitialized" do
      lambda { Sputnik.client }.should raise_exception(Sputnik::ConnectionNotAuthenticatedError)
    end
    it "no error when initialized" do
      Sputnik.authenticate(:apikey => 'derp')
      lambda { Sputnik.client }.should_not raise_exception(Sputnik::ConnectionNotAuthenticatedError)
    end
  end

  describe "client" do
    before do
      Sputnik.authenticate(:apikey => 'derp')
    end
    [[403, ForbiddenError],
     [404, NotFoundError],
     [500, InternalServerError],
     [501, NotImplementedError]
    ].each do |code, err|
      it "verify #{code} error" do
        response = Struct.new(:status, :body).new(code, '{"error" : "Error Message"}')
        Sputnik.client.stub_chain(:connect, :get).and_return(response)
        lambda { Sputnik.client.get('/') }.should raise_exception(err)
      end
    end
  end
end
