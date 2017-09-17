require 'spec_helper'

describe 'software::vcsscm::git' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        if facts[:operatingsystem] == 'Darwin'
          it { is_expected.to compile.and_raise_error(/is not supported on Darwin./) }
        else
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git') }
        end
      end
    end
  end
end
