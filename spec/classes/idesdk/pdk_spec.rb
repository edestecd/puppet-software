require 'spec_helper'

describe 'software::idesdk::pdk' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        # rubocop:disable RSpec/RepeatedExample
        if facts[:os]['name'] == 'Darwin'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('puppetlabs/puppet/pdk').with_provider('brewcask') }
        elsif facts[:os]['name'] =~ %r{^(Debian|Ubuntu)$}
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('pdk') }
        elsif facts[:os]['name'] == 'windows'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('pdk').with_provider('chocolatey') }
        else
          it { is_expected.to compile.and_raise_error(%r{is not supported on }) }
        end
        # rubocop:enable RSpec/RepeatedExample
      end
    end
  end
end
