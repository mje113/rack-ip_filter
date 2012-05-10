# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'rack/ip_filter'

Gem::Specification.new do |gem|
  gem.authors       = ["Mike Evans"]
  gem.email         = ["mike@urlgonomics.com"]
  gem.description   = %q{White and clacklist IPs}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.add_dependency 'netaddr'
  gem.add_dependency 'rack'
  gem.add_development_dependency 'rack-test'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-ip_filter"
  gem.require_paths = ["lib"]
  gem.version       = Rack::IpFilter::VERSION
end
