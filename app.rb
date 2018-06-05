require 'logger'
require 'require_all'

require_all 'lib'


logger = Logger.new STDOUT

system = System.new

while true
  logger.info "CPU: #{system.cpu_load}, Memory: #{system.memory_usage}"
  sleep 1
end
