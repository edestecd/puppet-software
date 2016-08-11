# lib/puppet/provider/package/prefpanecompressed.rb

require 'puppet/provider/package'
Puppet::Type.type(:package).provide(:prefpanecompressed, :parent => Puppet::Provider::Package) do
  desc 'Installs a compressed .prefPane. Supports zip, tar.gz, tar.bz2'

  FLAVORZ = %w(zip tgz tar.gz tbz tbz2 tar.bz2).freeze

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
      f =~ /^\.puppet_prefpanecompressed_installed_/
    }.collect do |f|
      name = f.sub(/^\.puppet_prefpanecompressed_installed_/, '')
      yield name if block_given?
      name
    end
    # rubocop:enable Style/BlockDelimiters, Style/MultilineBlockChain
  end

  def self.instances
    instances_by_name.collect do |name|
      new(:name => name, :provider => :prefpanecompressed, :ensure => :installed)
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
    raise('Mac OS X compressed prefPanes must specify a package name') unless @resource[:name]
    raise('Mac OS X compressed prefPanes must specify a package source') unless @resource[:source]
    raise("Unknown flavor #{flavor}") unless FLAVORZ.include?(flavor)

    cached_source = @resource[:source]
    tmpdir = Dir.mktmpdir
    begin
      if %r{\A[A-Za-z][A-Za-z0-9+\-\.]*://} =~ cached_source
        cached_source = File.join(tmpdir, @resource[:name])
        curl '-o', cached_source, '-C', '-', '-L', '-s', '--url', @resource[:source]
        Puppet.debug "Success: curl transfered [#{@resource[:name]}]"
      end

      # rm '-rf', pane_path

      case flavor
      when 'zip'
        # unzip cached_source, '-d', '/Library/PreferencePanes'
        ditto '-xk', cached_source, '/Library/PreferencePanes'
      when 'tar.gz', 'tgz'
        tar '-zxf', cached_source, '-C', '/Library/PreferencePanes'
      when 'tar.bz2', 'tbz', 'tbz2'
        tar '-jxf', cached_source, '-C', '/Library/PreferencePanes'
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
  #  rm '-rf', pane_path
  #  rm '-f', receipt_path
  # end

  private

  def flavor
    @resource[:flavor] || @resource[:source].match(/\.(#{FLAVORZ.join('|')})$/i) { |m| m[1] }
  end

  # This is not always correct...
  def pane_path
    "/Library/PreferencePanes/#{@resource[:name]}.prefPane"
  end

  def receipt_path
    "/var/db/.puppet_prefpanecompressed_installed_#{@resource[:name]}"
  end
end
