require 'logger'
require 'require_all'
require_all 'lib'

logger = Logger.new STDOUT

logger.info "Monitoring started!"

system = System.new ENV['HOSTS']
storage = Storage.new ENV['CLICKHOUSE']

while true


  data =  { host: system.host, cpu_load: system.cpu_load.round(2), memory_usage: system.memory_usage.round(2) }
  logger.info "#{data.to_json}"

  storage.write data

  `ls`
  sleep 1
end
