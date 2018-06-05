require 'clickhouse'
require "logger"
Clickhouse.logger = Logger.new(STDOUT)

class Storage
  TABLE = 'server_stats'.freeze

  def initialize(clickhouse_host)
    Clickhouse.establish_connection host: clickhouse_host
    create_table
  end

  def write(data)
    connection.insert_rows(TABLE, names: %w(year date time dt host cpu_load memory_usage)) do |rows|
      now = Time.now

      rows << [
        now.year,
        now.strftime('%Y-%M-%d'),
        now.strftime('%Y-%M-%d %H:%m'),
        data[:host],
        data[:cpu_load].to_f * 1000,
        data[:memory_usage].to_f * 1000
      ]
    end
  end

  private

  def connection
    @connection ||= Clickhouse.connection
  end

  def create_table
    connection.create_table TABLE do |t|
      t.uint16 :year
      t.date :date
      t.date_time :dt
      t.string :host
      t.uint16 :cpu_load # 1 - 1000
      t.uint16 :memory_usage # 1 - 1000
      t.engine "MergeTree(date, (year, date), 8192)"
    end
  rescue
  end
end
