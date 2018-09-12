require 'spec_helper'

describe 'software::virtualization::docker' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        if ['Darwin', 'windows'].include?(facts[:os]['name'])
          it { is_expected.to compile.with_all_deps }
        else
          it { is_expected.to compile.and_raise_error(%r{is not supported on }) }
        end
      end
    end
  end
end
