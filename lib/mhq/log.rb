module Mhq
  class Log < Base
    default_task :show
    namespace :logs

    desc "show", "logs for database"
    method_option :db, :aliases => "-d", :desc => "Database name", :type => :string, :required => true
    method_option :host, :aliases => "-h", :desc => "Hostname to restrict", :type => :string
    def show(filter_host = nil)
      auth_me
      filter_host ||= options.host

      logs = []
      db = MongoHQ::Database.find(options.db)
      db.logs.members.each do |member|
        host = (member.host.split(/[\.\:]/) - db.deployment_path.split(/[\.\:]/)).join(".")
        host == "" ? db.name.strip : host

        next if !filter_host.nil? && host != filter_host

        latest_log = "\n" + member.log
        {"Jan" => "01", "Feb" => "02", "Mar" => "03", "Apr" => "04", "May" => "05", "Jun" => "06", "Jul" => "07", "Aug" => "08", "Sep" => "09", "Oct" => "10", "Nov" => "11", "Dec" => "12"}.each do |find, replace|
          latest_log.gsub!(find, replace)
        end

        logs += latest_log.gsub(/\n([^\ ]+)\ ([^\ ]+)\ ([^\ ]+)\ ([^\ ]+)\ /, "\n\\2-\\3 \\4 #{host} ").split(/\n/)
      end
      say logs.compact.sort.join("\n")
    end
  end
end