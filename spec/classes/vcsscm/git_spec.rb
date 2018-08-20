require 'spec_helper'

describe 'software::vcsscm::git' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      # rubocop:disable RSpec/RepeatedExample
      context 'with defaults' do
        if facts[:os]['name'] == 'Darwin'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git').with_provider('brew') }
          it { is_expected.not_to contain_package('bash-completion') }
        elsif facts[:os]['name'] == 'windows'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git').with_provider('chocolatey') }
          it { is_expected.not_to contain_package('bash-completion') }
        elsif ['Debian', 'Ubuntu'].include?(facts[:os]['name'])
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git') }
          it { is_expected.not_to contain_package('gitk') }
          it { is_expected.not_to contain_package('git-gui') }
          it { is_expected.not_to contain_package('bash-completion') }
          it { is_expected.not_to contain_vcsrepo('/opt/bash-git-prompt/') }
          it { is_expected.not_to contain_file('/etc/bash_completion.d/bash-git-prompt') }
          it { is_expected.not_to contain_file('/etc/gitconfig') }
          it { is_expected.not_to contain_file('/etc/skel/.config/git/config') }
          it { is_expected.not_to contain_file('/etc/skel/.config/git/ignore') }
        end
      end

      context 'with gui' do
        let :params do
          {
            gui: true,
          }
        end

        if facts[:os]['name'] == 'Darwin'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git').with_provider('brew') }
          it { is_expected.not_to contain_package('gitk') }
          it { is_expected.not_to contain_package('git-gui') }
        elsif ['Debian', 'Ubuntu'].include?(facts[:os]['name'])
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git') }
          it { is_expected.to contain_package('gitk') }
          it { is_expected.to contain_package('git-gui') }
        end
      end

      context 'with bash completion and prompt' do
        let :params do
          {
            bash_completion: true,
            bash_prompt: true,
          }
        end

        if facts[:os]['name'] == 'Darwin'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git').with_provider('brew') }
          it { is_expected.to contain_package('bash-completion').with_provider('brew') }
        elsif facts[:os]['name'] == 'windows'
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git').with_provider('chocolatey') }
          it { is_expected.not_to contain_package('bash-completion') }
        elsif ['Debian', 'Ubuntu'].include?(facts[:os]['name'])
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git') }
          it { is_expected.to contain_package('bash-completion') }
          it { is_expected.to contain_vcsrepo('/opt/bash-git-prompt/') }
          it {
            is_expected.to contain_file('/etc/bash_completion.d/bash-git-prompt')
              .with_source('puppet:///modules/software/vcsscm/git/bash-git-prompt')
          }
        end
      end

      context 'with booleans for gitconfig and gitignore' do
        let :params do
          {
            gitconfig: true,
            gitignore: true,
          }
        end

        if ['Debian', 'Ubuntu'].include?(facts[:os]['name'])
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git') }
          it {
            is_expected.to contain_file('/etc/gitconfig')
              .with_source('puppet:///modules/software/vcsscm/git/system-gitconfig')
          }
          it {
            is_expected.to contain_file('/etc/skel/.config/git/config')
              .with_source('puppet:///modules/software/vcsscm/git/user-gitconfig')
          }
          it {
            is_expected.to contain_file('/etc/skel/.config/git/ignore')
              .with_source('puppet:///modules/software/vcsscm/git/user-gitignore')
          }
        end
      end

      context 'with strings for gitconfig and gitignore' do
        let :params do
          {
            gitconfig: 'puppet:///modules/user-supplied/custom/user-gitconfig',
            gitignore: 'puppet:///modules/user-supplied/custom/user-gitignore',
          }
        end

        if ['Debian', 'Ubuntu'].include?(facts[:os]['name'])
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git') }
          it { is_expected.not_to contain_file('/etc/gitconfig') }
          it {
            is_expected.to contain_file('/etc/skel/.config/git/config')
              .with_source('puppet:///modules/user-supplied/custom/user-gitconfig')
          }
          it {
            is_expected.to contain_file('/etc/skel/.config/git/ignore')
              .with_source('puppet:///modules/user-supplied/custom/user-gitignore')
          }
        end
      end

      context 'with hashes for gitconfig and gitignore' do
        let :params do
          {
            gitconfig: {
              system: 'puppet:///modules/user-supplied/custom/system-gitconfig',
              user: 'puppet:///modules/user-supplied/custom/user-gitconfig',
            },
            gitignore: {
              user: 'puppet:///modules/user-supplied/custom/user-gitignore',
            },
          }
        end

        if ['Debian', 'Ubuntu'].include?(facts[:os]['name'])
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('git') }
          it {
            is_expected.to contain_file('/etc/gitconfig')
              .with_source('puppet:///modules/user-supplied/custom/system-gitconfig')
          }
          it {
            is_expected.to contain_file('/etc/skel/.config/git/config')
              .with_source('puppet:///modules/user-supplied/custom/user-gitconfig')
          }
          it {
            is_expected.to contain_file('/etc/skel/.config/git/ignore')
              .with_source('puppet:///modules/user-supplied/custom/user-gitignore')
          }
        end
      end
      # rubocop:enable RSpec/RepeatedExample
    end
  end
end
