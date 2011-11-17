Gem::Specification.new do |s|
  s.name              = "redis-mmm"
  s.version           = "0.1.0"
  s.summary           = "Manages a set of redis servers replicating each other"
  s.description       = "Automatic / manual failover"
  s.authors           = ["Michael Siebert"]
  s.email             = ["siebertm85@googlemail.com"]
  s.homepage          = "http://github.com/siebertm/redis-mmm"
  s.files = ["README", "bin/redis_mmm"]

  s.executables.push("redis_mmm")
  s.add_dependency("redis")
  s.add_dependency("thor")
  s.add_dependency("parseconfig")
end
