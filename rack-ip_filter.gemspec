# -*- encoding: utf-8 -*-
require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mike Evans"]
  gem.email         = ["mike@urlgonomics.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.add_dependency 'netaddr'
  gem.add_dependency 'rack'
  gem.add_dependency 'rack-test'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-ip_filter"
  gem.require_paths = ["lib"]
  gem.version       = IpFilter::VERSION
end
