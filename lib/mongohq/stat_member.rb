module MongoHQ
  class StatMember < Base

    def index_misses_percentage
      value = send("indexCounters/btree/misses".to_sym) / send("indexCounters/btree/accesses".to_sym)
      value.nan? ? 0 : value
    end

    def queue_lengths
      "#{send("globalLock/currentQueue/readers".to_sym)}|#{send("globalLock/currentQueue/writers".to_sym)}"
    end

    def active_clients
      "#{send("globalLock/activeClients/readers".to_sym)}|#{send("globalLock/activeClients/writers".to_sym)}"
    end
  end
end
