require 'spec_helper'
require 'mongohq'
require 'fakeweb'

describe MongoHQ::DatabaseStats do
  context "should stats" do
    it "is successful" do
      FakeWeb.register_uri(:get, "https://api.mongohq.com/deployments/my_database.mongohq.com:10005/stats?_apikey=sekret",
                           :status => "200",
                           :body => "[{\"time\":1328824091,\"members\":[{\"timeSpan\":32.931,\"host\":\"node0.orchid.mongohq.com:10005\",\"currentTime\":\"2012-02-09 21:48:11 UTC\",\"globalLock/totalTime\":985625.6414928184,\"globalLock/lockTime\":909875.6490844494,\"globalLock/ratio\":0.2606986413524294,\"mem/bits\":64,\"mem/resident\":3022,\"mem/virtual\":12010,\"mem/supported\":true,\"mem/mapped\":10476,\"connections/current\":82,\"connections/available\":6471,\"extra_info/heap_usage_bytes\":521638512,\"extra_info/page_faults\":68.11211320640128,\"indexCounters/btree/accesses\":0.15183261972002066,\"indexCounters/btree/hits\":0.15183261972002066,\"indexCounters/btree/misses\":0.0,\"indexCounters/btree/resets\":0.0,\"backgroundFlushing/total_ms\":10.324618140961405,\"cursors/totalOpen\":1,\"cursors/timedOut\":0.0,\"network/bytesIn\":9870639.822659502,\"network/bytesOut\":1921323.8589778629,\"network/numRequests\":54.02204609638335,\"opcounters/insert\":0.12146609577601652,\"opcounters/query\":4.008381160608545,\"opcounters/update\":33.251343718684524,\"opcounters/delete\":0.0,\"opcounters/getmore\":0.33403176338404544,\"opcounters/command\":16.82305426497829,\"asserts/regular\":0.0,\"asserts/warning\":0.0,\"asserts/msg\":0.0,\"asserts/user\":0.0,\"asserts/rollovers\":0.0,\"member\":\"node0.orchid.mongohq.com:10005\"},{\"timeSpan\":20.901,\"host\":\"node1.orchid.mongohq.com:10005\",\"currentTime\":\"2012-02-09 21:48:11 UTC\",\"globalLock/totalTime\":991467.011147792,\"globalLock/lockTime\":25792.593655805944,\"globalLock/ratio\":0.2402082987997547,\"mem/bits\":64,\"mem/resident\":2020,\"mem/virtual\":8773,\"mem/supported\":true,\"mem/mapped\":8429,\"connections/current\":9,\"connections/available\":6544,\"extra_info/heap_usage_bytes\":304864,\"extra_info/page_faults\":9.281852542940529,\"indexCounters/btree/accesses\":0.0956892014736137,\"indexCounters/btree/hits\":0.0956892014736137,\"indexCounters/btree/misses\":0.0,\"indexCounters/btree/resets\":0.0,\"backgroundFlushing/total_ms\":0.0,\"cursors/totalOpen\":0,\"cursors/timedOut\":0.0,\"network/bytesIn\":383.61800870771737,\"network/bytesOut\":1486.3882110903785,\"network/numRequests\":5.16721687957514,\"opcountersRepl/insert\":0.0,\"opcountersRepl/query\":0.0,\"opcountersRepl/update\":3.301277450839673,\"opcountersRepl/delete\":0.0,\"opcountersRepl/getmore\":0.0,\"opcountersRepl/command\":0.0,\"opcounters/insert\":0.0,\"opcounters/query\":0.0,\"opcounters/update\":0.0,\"opcounters/delete\":0.0,\"opcounters/getmore\":0.0,\"opcounters/command\":5.16721687957514,\"asserts/regular\":0.0,\"asserts/warning\":0.0,\"asserts/msg\":0.0,\"asserts/user\":0.0,\"asserts/rollovers\":0.0,\"member\":\"node1.orchid.mongohq.com:10005\"}]}]")
      MongoHQ.authenticate(:apikey => "sekret")
      db    = MongoHQ::Database.new(:hostname => "my_database.node0.mongohq.com", :port => "10005")
      stats = db.stats

      stats.members.count.should == 2
    end
  end
end
