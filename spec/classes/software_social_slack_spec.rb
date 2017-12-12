require 'spec_helper'

describe 'software::social::slack' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        if facts[:operatingsystem] =~ /^(Debian|Ubuntu)$/
          it { is_expected.to compile.with_all_deps }
          it {
            is_expected.to contain_apt__source('slack')
              .with_location('https://packagecloud.io/slacktechnologies/slack/debian')
          }
          it { is_expected.to contain_package('slack-desktop') }
        else
          it { is_expected.to compile.and_raise_error(/is not supported on /) }
        end
      end
    end
  end
end
