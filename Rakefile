require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']
PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.relative = true

task :default => %w(test)

desc 'Run all tests (rubocop, puppet-lint, rspec)'
task :test do
  sh 'rm -rf pkg'
  ['rubocop', 'rake lint'].each do |task|
    sh "bundle exec #{task}"
  end
  puts "\nAll tests passing..."
end
