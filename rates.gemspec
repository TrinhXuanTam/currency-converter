# frozen_string_literal: true

require File.expand_path('lib/rates/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'rates'
  s.version     = Rates::VERSION
  s.homepage    = 'https://gitlab.fit.cvut.cz/NI-RUB/B221/trinhxu2/-/tree/master'
  s.license     = 'MIT'
  s.author      = 'Xuan Tam Trinh'
  s.email       = 'trinhxu2@fit.cvut.cz'

  s.summary     = 'Currency rates conversion utility.'
  s.description = 'Currency conversion utility that is able to convert from any currency to any currency.'

  s.files       = Dir['bin/*', 'lib/**/*', '*.gemspec', 'LICENSE*', 'README*']
  s.executables = Dir['bin/*'].map { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.6'

  s.add_runtime_dependency 'net-http', '~> 0.2.0'
  s.add_runtime_dependency 'thor', '~> 1.2.0'
end
