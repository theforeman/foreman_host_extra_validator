require File.expand_path('lib/foreman_host_extra_validator/version', __dir__)
require 'date'

Gem::Specification.new do |s|
  s.name        = 'foreman_host_extra_validator'
  s.version     = ForemanHostExtraValidator::VERSION
  s.license     = 'GPL-3.0'
  # rubocop:disable Date
  s.date        = Date.today.to_s
  # rubocop:enable Date
  s.authors     = ['Timo Goebel']
  s.email       = ['timo.goebel@dm.de']
  s.homepage    = 'https://github.com/theforeman/foreman_host_extra_validator'
  s.summary     = 'This plugin adds extra validations to a host.'
  # also update locale/gemspec.rb
  s.description = 'This plugin adds extra validations to a host.'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'

  s.required_ruby_version = '>= 2.7', '< 4'
end
