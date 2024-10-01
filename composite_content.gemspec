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

  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'rubygems_mfa_required' => 'true',

    'bug_tracker_uri' => 'https://github.com/notus-sh/composite_content/issues',
    'changelog_uri' => 'https://github.com/notus-sh/composite_content/blob/main/CHANGELOG.md',
    'homepage_uri' => 'https://github.com/notus-sh/composite_content',
    'source_code_uri' => 'https://github.com/notus-sh/composite_content',
    'funding_uri' => 'https://opencollective.com/notus-sh'
  }

  spec.require_paths = ['lib']

  excluded_dirs = %r{^(.github|dev|spec)/}
  excluded_files = %w[.gitignore .rspec Gemfile Gemfile.lock Rakefile]
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(excluded_dirs) || excluded_files.include?(f)
  end

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'active_model_validations_reflection'
  spec.add_dependency 'acts_as_list', '>= 1.0.4'
  spec.add_dependency 'cocooned', '~> 2.0', '>= 2.4'
  spec.add_dependency 'rails', '>= 6.1.0'

  # Development tools
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
end
