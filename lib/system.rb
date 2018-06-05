require 'net/ssh'

class System
  def initialize(host)
    @host = host
  end

  def cpu_load
    # 19:18:51 up 51 min,  load average: 0.03, 0.01, 0.00
    execute('uptime').match(/load averages?: ([^\s]+)/)[1].to_f
  end

  def memory_total
    execute("free -m | grep Mem | awk '{print $2}'").to_f
  end

  def memory_used
    execute("free -m | grep Mem | awk '{print $3}'").to_f
  end

  def memory_usage
    memory_used / memory_total
  end

  private

  def execute(command)
    Net::SSH.start(@host, 'root') do |ssh|
      ssh.exec!(command)
    end
  end
end
