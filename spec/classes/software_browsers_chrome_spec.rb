require 'spec_helper'

describe 'software::browsers::chrome' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
