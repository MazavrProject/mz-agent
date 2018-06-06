require 'logger'
require 'require_all'
require_all 'lib'

logger = Logger.new STDOUT

logger.info "Monitoring started!"

systems = ENV['HOSTS'].split(',').map { |host| System.new host }
storage = Storage.new(
  host: ENV['CLICKHOUSE_HOST'], 
  user: ENV['CLICKHOUSE_USER'], 
  password: ENV['CLICKHOUSE_PASSWORD'], 
  database: ENV['CLICKHOUSE_DATABASE'], 
)

while true

  systems.each do |system|
    data =  { host: system.host, cpu_load: system.cpu_load.round(2), memory_usage: system.memory_usage.round(2) }
    logger.info "#{data.to_json}"

    storage.write data
  end

  `ls`
  sleep 1
end
