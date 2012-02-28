module Mhq
  class Stats < Base
    default_task :show

    namespace :stats

    desc "show", "Show stats for database"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    method_option :tail, :aliases => "-f", :desc => "Tail stats continuously.", :type => :boolean
    method_option :host, :aliases => "-h", :desc => "Hostname to restrict", :type => :string
    def show
      auth_me

      @db = MongoHQ::Database.find(options.db)
      if !@db.nil? && !@db.shared
        loop_num = 0
        loop do
          write_header if loop_num % 10 == 0
          write_stats @db.stats, options.host
          break if !options.tail
          loop_num += 1
          sleep 1
        end
      elsif
        say "Stats not available on Sandbox and Micro plans."
      end
    rescue MongoHQ::Database::DbNotFound
      say "Database named #{options.db} not found"
      exit
    end

    no_tasks {
      def write_header
        say sprintf(headers.map { |s| s[1] }.join(""), *headers.map { |m| m[0] })
      end

      def write_stats(stats, hostname_filter = nil)
        wrote_stats = 0
        stats.members.sort_by{|m| [m.host.match(/\d?(\D*)$/)[1], m.host]}.each do |member|
          next if !hostname_filter.nil? && !((member.host.split(/[\.\:]/) - @db.deployment_path.split(/[\.\:]/)).join(".") =~ Regexp.new(hostname_filter))
          wrote_stats += 1
          write_stat(member, hostname_filter)
        end
        puts "" if wrote_stats > 1
        say("No stats for database and host requested") && exit unless wrote_stats
      end

      def write_stat(member, hostname_filter)
        stats = headers.map { |s| !s[2].nil? ? format_field(member.send(s[2].to_sym), s[2]) : "" }
        say sprintf(headers.map { |s| s[1] }.join(""), *stats) + "\n"
      end

      def headers
        [["host", '% -10s', "host"],
         ["insert", '%7s', "opcounters/insert"],
         ["query", '%7s', "opcounters/query"],
         ["update", '%7s', "opcounters/update"],
         ["delete", '%7s', "opcounters/delete"],
         ["getmore", '%8s', "opcounters/getmore"],
         ["command", '%8s', "opcounters/command"],
         ["flushes", '%8s'],
         ["mapped", '%7s', "mem/mapped"],
         ["vsize", '%7s', "mem/virtual"],
         ["res", '%7s', "mem/resident"],
         ["faults", '%7s', "extra_info/page_faults"],
         ["locked %", '%9s', "locked_percentage"],
         ["idx miss %", '%11s', "index_misses_percentage"],
         ["qr|qw", '%10s', "queue_lengths"],
         ["ar|aw", '%8s', "active_clients"],
         ["netIn", '%7s', "network/bytesIn"],
         ["netOut", '%7s', "network/bytesOut"],
         ["conn", '%6s', "connections/current"],
         ["time", '%16s', "currentTime"]
        ]
      end

      def format_field(value, header)
        if header == "host"
          response = (value.gsub(/:[0-9]+$/, "").split(/[\.\:]/) - @db.deployment_path.split(/[\.\:]/)).join(".")
          response == "" ? @db.name.strip : response
        elsif header =~ /^mem/
          human_size(value * 1024 * 1024)
        elsif header =~ /^network/ && (value.is_a?(Integer) || value.is_a?(Float))
          human_size(value)
        elsif value.is_a?(Float)
          value.to_i rescue value
        elsif value.is_a?(String) && value =~ /^[\d]{4}\-[\d]{2}\-[\d]{2}/
          Time.parse(value).strftime("%m/%d %H:%M:%S")
        else
          value
        end
      end
    }
  end
end
