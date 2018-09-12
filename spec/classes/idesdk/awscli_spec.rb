require 'spec_helper'

describe 'software::idesdk::awscli' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        if os_facts[:os]['name'] == 'Darwin'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('awscli').with_provider('brew') }
        else
          it { is_expected.to compile.and_raise_error(%r{is not supported on }) }
        end
      end
    end
  end
end
