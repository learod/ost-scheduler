require "cutest"
require "ost"
require_relative "../lib/ost-scheduler"

Ost.redis = Redic.new("redis://127.0.0.1:6379")

prepare do
  Ost.redis.call("FLUSHALL")
end
