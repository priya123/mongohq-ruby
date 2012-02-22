module MongoHQ
  class StatMember < Base

    def index_misses_percentage
      ((send("indexCounters/btree/misses".to_sym).to_f / send("indexCounters/btree/accesses".to_sym).to_f) * 100).round(1).to_s
    end

    def queue_lengths
      "#{send("globalLock/currentQueue/readers".to_sym)}|#{send("globalLock/currentQueue/writers".to_sym)}"
    end

    def active_clients
      "#{send("globalLock/activeClients/readers".to_sym)}|#{send("globalLock/activeClients/writers".to_sym)}"
    end

    def locked_percentage
      ((send("globalLock/lockTime".to_sym).to_f / send("globalLock/totalTime".to_sym).to_f) * 100).round(1).to_s
    end
  end
end
