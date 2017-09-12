source ENV['GEM_SOURCE'] || 'https://rubygems.org'

group :unit_tests do
  gem 'json',                                                      :require => false
  gem 'metadata-json-lint',                                        :require => false
  gem 'puppet-lint-absolute_classname-check',                      :require => false
  gem 'puppet-lint-absolute_template_path',                        :require => false
  gem 'puppet-lint-alias-check',                                   :require => false
  gem 'puppet-lint-appends-check',                                 :require => false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check', :require => false
  gem 'puppet-lint-empty_string-check',                            :require => false
  gem 'puppet-lint-file_ensure-check',                             :require => false
  gem 'puppet-lint-file_source_rights-check',                      :require => false
  gem 'puppet-lint-leading_zero-check',                            :require => false
  gem 'puppet-lint-numericvariable',                               :require => false
  gem 'puppet-lint-resource_outside_class-check',                  :require => false
  gem 'puppet-lint-resource_reference_syntax',                     :require => false
  gem 'puppet-lint-spaceship_operator_without_tag-check',          :require => false
  gem 'puppet-lint-strict_indent-check',                           :require => false
  gem 'puppet-lint-trailing_comma-check',                          :require => false
  gem 'puppet-lint-trailing_newline-check',                        :require => false
  gem 'puppet-lint-undef_in_function-check',                       :require => false
  gem 'puppet-lint-unquoted_string-check',                         :require => false
  gem 'puppet-lint-usascii_format-check',                          :require => false
  gem 'puppet-lint-variable_contains_upcase',                      :require => false
  gem 'puppet-lint-version_comparison-check',                      :require => false
  gem 'puppetlabs_spec_helper',                                    :require => false
  gem 'rspec-puppet-facts',                                        :require => false
  gem 'rubocop',                                                   :require => false
end

group :development do
  gem 'librarian-puppet', :require => false
  gem 'simplecov',        :require => false
end

group :system_tests do
  gem 'beaker-rspec', :require => false
  gem 'serverspec',   :require => false
end

if (facterversion = ENV['FACTER_GEM_VERSION'])
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if (puppetversion = ENV['PUPPET_GEM_VERSION'])
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '~> 4.10', :require => false
end

# vim:ft=ruby
