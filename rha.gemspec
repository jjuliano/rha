require_relative 'lib/rha/version'

Gem::Specification.new do |s|
  s.name = %q{rha}
  s.version = Rha::VERSION::STRING
  s.date = Time.now
  s.authors = ["Joel Bryan Juliano"]
  s.email = %q{joelbryan.juliano@gmail.com}
  s.summary = %q{Heartbeat High Availability Cluster API for Ruby}
  s.homepage = %q{http://github.com/jjuliano/rha}
  s.description = %q{A gem providing a ruby interface to Heartbeat High Availability Cluster.}
  s.files = [ "README.md", "Changelog", "LICENSE", "setup.rb",
              "lib/rha.rb", "lib/rha/version.rb",
              "test/test_rha.rb", "test/test_helper.rb",
              "lib/rha/daemon.rb", "lib/rha/ha_cf.rb",
              "lib/rha/haresources.rb", "lib/rha/authkeys.rb"]
  s.license = "GNU LGPLv3"
end

