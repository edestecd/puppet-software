require 'spec_helper'

describe 'software::idesdk::tfenv' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        if facts[:os]['name'] == 'Darwin'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('tfenv').with_provider('brew') }
        else
          it { is_expected.to compile.and_raise_error(%r{is not supported on }) }
        end
      end
    end
  end
end
