require 'spec_helper'

describe 'software::vcsscm::git' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('git') }
      end
    end
  end
end
