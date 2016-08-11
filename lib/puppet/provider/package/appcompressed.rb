# lib/puppet/provider/package/appcompressed.rb

require 'puppet/provider/package'
Puppet::Type.type(:package).provide(:appcompressed, :parent => Puppet::Provider::Package) do
  desc 'Installs a compressed .app. Supports zip, tar.gz, tar.bz2'

  FLAVORS = %w(zip tgz tar.gz tbz tbz2 tar.bz2).freeze

  confine :operatingsystem => :darwin

  commands :curl  => '/usr/bin/curl'
  commands :ditto => '/usr/bin/ditto'
  commands :tar   => '/usr/bin/tar'
  # commands :rm    => '/bin/rm'

  # JJM We store a cookie for each installed .app.compressed in /var/db
  def self.instances_by_name
    # Allow this gross code....
    # rubocop:disable Style/BlockDelimiters, Style/MultilineBlockChain
    Dir.entries('/var/db').find_all { |f|
      f =~ /^\.puppet_appcompressed_installed_/
    }.collect do |f|
      name = f.sub(/^\.puppet_appcompressed_installed_/, '')
      yield name if block_given?
      name
    end
    # rubocop:enable Style/BlockDelimiters, Style/MultilineBlockChain
  end

  def self.instances
    instances_by_name.collect do |name|
      new(:name => name, :provider => :appcompressed, :ensure => :installed)
    end
  end

  def query
    return unless File.exist?(receipt_path)
    {
      :name   => @resource[:name],
      :ensure => :installed
    }
  end

  def install
    raise('Mac OS X compressed apps must specify a package name') unless @resource[:name]
    raise('Mac OS X compressed apps must specify a package source') unless @resource[:source]
    raise("Unknown flavor #{flavor}") unless FLAVORS.include?(flavor)

    cached_source = @resource[:source]
    tmpdir = Dir.mktmpdir
    begin
      if %r{\A[A-Za-z][A-Za-z0-9+\-\.]*://} =~ cached_source
        cached_source = File.join(tmpdir, @resource[:name])
        curl '-o', cached_source, '-C', '-', '-L', '-s', '--url', @resource[:source]
        Puppet.debug "Success: curl transfered [#{@resource[:name]}]"
      end

      # rm "-rf", app_path

      case flavor
      when 'zip'
        # unzip cached_source, "-d", "/Applications"
        ditto '-xk', cached_source, '/Applications'
      when 'tar.gz', 'tgz'
        tar '-zxf', cached_source, '-C', '/Applications'
      when 'tar.bz2', 'tbz', 'tbz2'
        tar '-jxf', cached_source, '-C', '/Applications'
      else
        raise "Can't decompress flavor #{flavor}"
      end

      File.open(receipt_path, 'w') do |t|
        t.print "name: '#{@resource[:name]}'\n"
        t.print "source: '#{@resource[:source]}'\n"
      end
    ensure
      FileUtils.remove_entry_secure(tmpdir, true)
    end
  end

  # def uninstall
  #  rm "-rf", app_path
  #  rm "-f", receipt_path
  # end

  private

  def flavor
    @resource[:flavor] || @resource[:source].match(/\.(#{FLAVORS.join('|')})$/i) { |m| m[1] }
  end

  # This is not always correct...
  def app_path
    "/Applications/#{@resource[:name]}.app"
  end

  def receipt_path
    "/var/db/.puppet_appcompressed_installed_#{@resource[:name]}"
  end
end
