# lib/puppet/provider/package/apm.rb

require 'puppet/provider/package'

Puppet::Type.type(:package).provide(:apm, :parent => Puppet::Provider::Package) do
  desc 'Atom packages via `apm`.'

  has_feature :installable, :uninstallable, :upgradeable, :versionable

  commands :apm => 'apm'

  def self.parse(line, user)
    if line.chomp =~ / (\S+)@(\d+\.\d+\.\d+)/
      { :name => Regexp.last_match(1), :provider => :apm,
        :ensure => Regexp.last_match(2), :source => user }
    end
  end

  def self.instances_by_user(user)
    command = [command(:apm), :list, '--no-color']

    begin
      output = execute(command, command_opts(user))
      [].tap do |a|
        output.lines.each do |line|
          next unless (package = parse(line, user))
          a << new(package)
        end
      end.compact
    rescue Puppet::ExecutionFailure => e
      raise Puppet::Error, "Could not list atom packages: #{e}"
    end
  end

  def self.instances
    Dir.entries(home_prefix).reject { |u| u.start_with?('.') || u.eql?('Shared') }.collect do |user|
      instances_by_user(user)
    end.flatten
  end

  def query
    self.class.instances.each do |pkg|
      if @resource.name.eql?(pkg.name) && @resource.source.eql?(pkg.source)
        return pkg.properties
      end
    end
    nil
  end

  def latest
    command = [command(:apm), :upgrade, '--list', '--no-color']
    output = execute(command, self.class.command_opts(@resource[:source]))

    if output =~ / #{Regexp.escape @resource[:name]} (\d+\.\d+\.\d+) -> (\d+\.\d+\.\d+)/
      Regexp.last_match(2)
    else
      @property_hash[:ensure]
    end
  end

  def install
    command = [command(:apm), :install]

    should = @resource.should(:ensure)
    command << if [:latest, :installed, :present].include?(should)
                 @resource[:name]
               else
                 "#{@resource[:name]}@#{should}"
               end

    command << '--no-color'

    execute(command, self.class.command_opts(@resource[:source]))
  end

  def update
    install
  end

  def uninstall
    command = [command(:apm), :uninstall, @resource[:name], '--no-color']
    execute(command, self.class.command_opts(@resource[:source]))
  end

  def self.default_user(user)
    user || Facter.value(:id) || 'root'
  end

  def self.home(user)
    File.join(home_prefix, default_user(user))
  end

  def self.home_prefix
    case Facter.value(:kernel)
    when 'Darwin' then File.join('', 'Users')
    when 'Linux' then File.join('', 'home')
    else
      raise 'unsupported'
    end
  end

  def self.command_opts(user)
    Dir.chdir(home(user).to_s)
    @command_opts ||= {
      :combine            => true,
      :custom_environment => {
        'HOME'            => home(user).to_s,
        'PATH'            => '/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin'
      },
      :failonfail         => true,
      :uid                => default_user(user)
    }
  end
end
