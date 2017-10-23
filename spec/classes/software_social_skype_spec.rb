require 'spec_helper'

describe 'software::social::skype' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        if facts[:operatingsystem] == 'Darwin'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('Skype-7.33.206').with_provider('appdmg') }
        elsif facts[:operatingsystem] == 'Ubuntu'
          it { is_expected.to compile.with_all_deps }
          it {
            is_expected.to contain_apt__source('skype-partner')
              .with_location('http://archive.canonical.com/ubuntu')
          }
          it { is_expected.to contain_package('skype') }
        elsif facts[:operatingsystem] == 'windows'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('skype').with_provider('chocolatey') }
        else
          it { is_expected.to compile.and_raise_error(/is not supported on /) }
        end
      end
    end
  end
end
