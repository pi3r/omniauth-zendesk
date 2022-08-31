# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-zendesk/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Pierre Nespo"]
  gem.email         = ["pnespo@zendesk.com"]
  gem.description   = %q{Omniauth strategy for Zendesk}
  gem.summary       = %q{Omniauth strategy for Zendesk}
  gem.homepage      = "https://github.com/zendesk/omniauth-zendesk"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-zendesk"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Zendesk::VERSION

  gem.add_dependency 'omniauth', '>= 1.1', '< 3.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
