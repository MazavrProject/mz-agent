class System
  def cpu_load
    # 19:18:51 up 51 min,  load average: 0.03, 0.01, 0.00
    `uptime`.match(/load averages?: ([^\s]+)/)[0].to_f rescue nil
  end

  def memory_total
    `free -m | grep Mem | awk '{print $2}'`.to_f rescue nil
  end

  def memory_used
    `free -m | grep Mem | awk '{print $3}'`.to_f rescue nil
  end

  def memory_usage
    memory_used / memory_total
  end
end
