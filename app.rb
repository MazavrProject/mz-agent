require 'logger'
require 'require_all'

require_all 'lib'

logger.info "Monitoring started!"

logger = Logger.new STDOUT

system = System.new(ENV['HOSTS'])

while true
  logger.info "CPU: #{system.cpu_load.round(2)}, Memory: #{system.memory_usage.round(2)}"
  sleep 1
end
