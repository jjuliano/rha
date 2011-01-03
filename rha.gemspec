Gem::Specification.new do |s|
  s.name = %q{rha}
  s.version = "0.1.0"
  s.date = %q{2010-12-31}
  s.authors = ["Joel Bryan Juliano"]
  s.email = %q{joelbryan.juliano@gmail.com}
  s.summary = %q{A gem providing a ruby interface to Heartbeat High Availability Cluster}
  s.homepage = %q{http://github.com/jjuliano/rha}
  s.description = %q{A gem providing a ruby interface to Heartbeat High Availability Cluster.}
  s.files = [ "README", "Changelog", "MIT-LICENSE", "setup.rb",
              "lib/rha.rb", "lib/rha/version.rb",
              "test/test_rha.rb", "test/test_helper.rb",
              "lib/rha/daemon.rb", "lib/rha/ha_cf.rb",
              "lib/rha/haresources.rb", "lib/rha/authkeys.rb"]
end

