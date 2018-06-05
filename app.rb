require 'logger'
require 'require_all'
require_all 'lib'

logger = Logger.new STDOUT

logger.info "Monitoring started!"

system = System.new ENV['HOSTS']
storage = Storage.new(
  host: ENV['CLICKHOUSE_HOST'], 
  user: ENV['CLICKHOUSE_USER'], 
  password: ENV['CLICKHOUSE_PASSWORD'], 
)

while true


  data =  { host: system.host, cpu_load: system.cpu_load.round(2), memory_usage: system.memory_usage.round(2) }
  logger.info "#{data.to_json}"

  storage.write data

  `ls`
  sleep 1
end
