# frozen_string_literal: true

require_relative 'lib/composite_content/version'

Gem::Specification.new do |spec|
  spec.name          = 'composite_content'
  spec.version       = CompositeContent::VERSION
  spec.licenses      = ['Apache-2.0']
  spec.authors       = ['Gaël-Ian Havard']
  spec.email         = ['gael-ian@notus.sh']

  spec.summary       = 'Add composite content capacities to your ActiveRecord models.'
  spec.description   = 'Build complex contents for your ActiveRecord models in a controllable way.'
  spec.homepage      = 'https://github.com/notus-sh/composite_content'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.require_paths = ['lib']
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.required_ruby_version = '>= 2.6.0'

  spec.add_dependency 'acts_as_list',   '~> 1.0.4'
  spec.add_dependency 'rails',          '>= 6.0'

  # Development tools
  spec.add_development_dependency 'bundler',        '~> 2.1'
  spec.add_development_dependency 'rake',           '~> 13.0'
  spec.add_development_dependency 'rspec',          '~> 3.10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
end
