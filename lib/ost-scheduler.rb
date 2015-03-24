require "ost"
module OstScheduler
  TIME_PERIOD = ENV["TIME_PERIOD"] || "24"
  TIMEOUT_SCHEDULER = ENV["OST_TIMEOUT"] || "1"
  # /class Queue

    def push_at(time,value)
      score = time.to_i if time.class == Time
      redis.call("ZADD", @key, score, value)
    end


    def each_delayed(&block)
      loop do
        now = Time.now.to_i
        min_time = now - range_period
        items = redis.call("ZRANGEBYSCORE",@key , min_time,  now)
        if !items.count.zero?
          items.each do |item|
            block.call(item)
          end
          redis.call("ZREMRANGEBYSCORE",@key , min_time,  now)
        end 
        
        sleep(TIMEOUT_SCHEDULER.to_i)

        break if @stopping
      end
    end

    def range_period
      (TIME_PERIOD.to_i * 60 * 60)
    end

    def items
      if redis.call("TYPE", @key) == "zset"
        redis.call("ZRANGE", @key, 0, -1)
      else
        redis.call("LRANGE", @key, 0, -1)
      end
    end

    def size
      if redis.call("TYPE", @key) == "zset"
        redis.call("ZCARD", @key)
      else
        redis.call("LLEN", @key)
      end
    end

  # end
end

class Ost::Queue
  remove_method :items
  remove_method :size
  include OstScheduler
end

