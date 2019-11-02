# frozen_string_literal: true

RSpec.describe GemComet::GitCommand do
  let(:instance) { described_class.new }

  before { allow(instance).to receive(:execute).and_return(response) }

  shared_examples 'to execute git command' do |command|
    it do
      execute
      expect(instance).to have_received(:execute).with(command)
    end
  end

  describe '#uncommitted_files' do
    subject(:execute) { instance.uncommitted_files }

    context 'when exist uncommitted files' do
      let(:response) do
        <<~STDOUT
          M lib/gem_comet.rb
          M lib/gem_comet/release.rb
          ?? lib/gem_comet/verify_git_condition.rb
          ?? spec/lib/gem_comet/verify_git_condition_spec.rb
        STDOUT
      end

      let(:expected_result) do
        [
          'M lib/gem_comet.rb',
          'M lib/gem_comet/release.rb',
          '?? lib/gem_comet/verify_git_condition.rb',
          '?? spec/lib/gem_comet/verify_git_condition_spec.rb'
        ]
      end

      it_behaves_like 'to execute git command', 'git status --short'
      it { is_expected.to eq expected_result }
    end

    context 'when unexist uncommitted files' do
      let(:response) { '' }

      it_behaves_like 'to execute git command', 'git status --short'
      it { is_expected.to eq [] }
    end
  end

  describe '#current_branch' do
    subject(:execute) { instance.current_branch }

    let(:response) { 'master' }

    it_behaves_like 'to execute git command', 'git rev-parse --abbrev-ref HEAD'
    it { is_expected.to eq 'master' }
  end

  describe '#checkout' do
    subject(:execute) { instance.checkout('master') }

    let(:response) do
      <<~STDOUT
        Switched to branch 'master'
        Your branch is up to date with 'origin/master'.
      STDOUT
    end

    it_behaves_like 'to execute git command', 'git checkout master'
  end
end
