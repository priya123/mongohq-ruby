module Mhq
  class Log < Thor

    desc "show <database name>", "Show logs for database"
    method_option :host, :aliases => "-h", :desc => "Hostname to restrict", :type => :string
    def show(database_name, filter_host = nil)
      filter_host ||= options.host

      logs = []
      db = MongoHQ::Database.find(database_name)
      db.logs.members.each do |member|
        host = (member.host.split(/[\.\:]/) - db.deployment_path.split(/[\.\:]/)).join(".")
        host == "" ? db.name.strip : host

        next if !filter_host.nil? && host != filter_host

        latest_log = "\n" + member.log
        {"Jan" => "01", "Feb" => "02", "Mar" => "03", "Apr" => "04", "May" => "05", "Jun" => "06", "Jul" => "07", "Aug" => "08", "Sep" => "09", "Oct" => "10", "Nov" => "11", "Dec" => "12"}.each do |find, replace|
          latest_log.gsub!(find, replace)
        end

        logs += latest_log.gsub('Feb ', '02-').gsub(/\n([^\ ]+)\ ([^\ ]+)\ ([^\ ]+)\ ([^\ ]+)\ /, "\n\\2 \\3 \\4 #{host} ").split(/\n/)
      end
      say logs.compact.sort.join("\n")
    end
  end
end