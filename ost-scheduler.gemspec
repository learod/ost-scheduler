Gem::Specification.new do |s|
  s.name              = "ost-scheduler"
  s.version           = "0.1.0"
  s.summary           = "Redis based queues and workers in the future."
  s.description       = "Ost-scheduler lets you manage queues and workers with Redis."
  s.authors           = ["Leandro Rodriguez"]
  s.email             = ["learod17@gmail.com"]
  s.homepage          = "http://github.com/learod/ost-scheduler"
  s.license           = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_dependency "ost"
  s.add_development_dependency "cutest"
end

