# lib/puppet/provider/package/apm.rb

require 'puppet/provider/package'

Puppet::Type.type(:package).provide(:apm, :parent => Puppet::Provider::Package) do
  desc 'Atom packages via `apm`.'

  has_feature :installable, :uninstallable, :upgradeable, :versionable

  commands :apm => 'apm'

  def self.parse(line)
    if line.chomp =~ /── (\S+)@(\d+\.\d+\.\d+)/
      { :ensure => Regexp.last_match(2), :name => Regexp.last_match(1), :provider => :apm }
    end
  end

  def self.instances
    command = [command(:apm), :list, '--no-color']

    begin
      output = execute(command, command_opts)
      [].tap do |a|
        output.lines.each do |line|
          next unless (package = parse(line))
          a << new(package)
        end
      end.compact
    rescue Puppet::ExecutionFailure => e
      raise Puppet::Error, "Could not list atom packages: #{e}"
    end
  end

  def query
    self.class.instances.each do |pkg|
      return pkg.properties if @resource.name == pkg.name
    end
    nil
  end

  def latest
    command = [command(:apm), :upgrade, '--list', '--no-color']
    output = execute(command, self.class.command_opts)

    if output =~ /── #{Regexp.escape @resource[:name]} (\d+\.\d+\.\d+) -> (\d+\.\d+\.\d+)/
      Regexp.last_match(2)
    else
      @property_hash[:ensure]
    end
  end

  def install
    command = [command(:apm), :install]

    should = @resource.should(:ensure)
    if [:latest, :installed, :present].include?(should)
      command << @resource[:name]
    else
      command << "#{@resource[:name]}@#{should}"
    end

    command << '--no-color'

    execute(command, self.class.command_opts)
  end

  def update
    install
  end

  def uninstall
    command = [command(:apm), :uninstall, @resource[:name], '--no-color']
    execute(command, self.class.command_opts)
  end

  def self.default_user
    @resource[:package_settings] && @resource[:package_settings][:user] ||
      Facter.value(:id) ||
      'root'
  end

  def self.home
    File.join('', homedir_prefix, default_user)
  end

  def self.homedir_prefix
    case Facter[:osfamily].value
    when 'Darwin' then 'Users'
    when 'Linux' then 'home'
    else
      fail 'unsupported'
    end
  end

  def self.command_opts
    @command_opts ||= {
      :combine            => true,
      :custom_environment => {
        'HOME'            => "#{home}",
        'PATH'            => '/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin'
      },
      :failonfail         => true,
      :uid                => default_user
    }
  end
end
