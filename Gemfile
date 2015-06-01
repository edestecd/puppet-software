source 'https://rubygems.org'

ruby '2.1.5', :engine => 'ruby', :engine_version => '2.1.5'

gem 'facter'
gem 'hiera'
gem 'puppet'

# Bundle edge puppet instead:
# gem 'puppet', :git => 'git://github.com/puppetlabs/puppet.git'

group :development, :test do
  gem 'rake',                                 :require => false
  gem 'rubocop',                              :require => false
  gem 'puppet-lint',                          :require => false
  gem 'puppet-lint-trailing_newline-check',   :require => false
  gem 'puppet-lint-variable_contains_upcase', :require => false
  gem 'puppet-lint-absolute_template_path',   :require => false
  gem 'puppet-lint-strict_indent-check',      :require => false
  gem 'puppet-lint-unquoted_string-check',    :require => false
  # gem 'rspec-puppet',           :require => false
  # gem 'puppetlabs_spec_helper', :require => false
  # gem 'serverspec',             :require => false
  # gem 'puppet-blacksmith',      :require => false
  # gem 'beaker',                 :require => false
  # gem 'beaker-rspec',           :require => false
end
