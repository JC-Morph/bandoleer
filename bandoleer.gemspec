# frozen_string_literal: true

require './lib/bandoleer/version'

Gem::Specification.new do |s|
  s.name    = 'bandoleer'
  s.version = Bandoleer::VERSION
  s.authors = 'JC-Morph'
  s.email   = 'jc_morph@caramail.com'

  s.homepage    = 'https://github.com/JC-Morph/bandoleer'
  s.summary     = 'Turn your ruby files into ruby vials'
  s.description = 'An IoC container focussing on the automatic extraction of' \
                  'constants from ruby files.'
  s.license     = 'GPL-3.0'

  s.metadata['homepage_uri']    = s.homepage
  s.metadata['source_code_uri'] = s.homepage

  s.files         = Dir['lib/*.rb', 'license', 'readme.md']
  s.executables  << 'bandoleer'

  s.add_dependency 'canister', '~> 0.9.1'
  s.add_dependency 'thor',     '~> 1.2.2'

  # Test
  s.add_development_dependency 'aruba',    '~> 2.1.0'
  s.add_development_dependency 'cucumber', '~> 8.0.0'
  s.add_development_dependency 'rspec',    '~> 3.12.0'

  # Lint
  s.add_development_dependency 'rubocop',       '~> 1.55.1'
  s.add_development_dependency 'rubocop-rspec', '~> 2.23.2'

  s.required_ruby_version = '>= 3.0.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
