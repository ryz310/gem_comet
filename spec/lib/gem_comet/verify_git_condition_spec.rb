# frozen_string_literal: true

RSpec.describe GemComet::VerifyGitCondition do
  before do
    allow(GemComet::GitCommand).to receive(:new).and_return(git_command)
  end

  let(:git_command) do
    instance_double(
      GemComet::GitCommand,
      execute: nil,
      uncommitted_files: uncommitted_files,
      current_branch: current_branch,
      checkout: nil,
      pull: nil
    )
  end

  let(:current_branch) { 'master' }

  describe '.call' do
    subject(:execute) { described_class.call }

    context 'when exists uncommitted files' do
      let(:uncommitted_files) do
        [
          'M lib/gem_comet.rb',
          'M lib/gem_comet/release.rb',
          '?? lib/gem_comet/verify_git_condition.rb',
          '?? spec/lib/gem_comet/verify_git_condition_spec.rb'
        ]
      end

      let(:error_message) do
        <<~MESSAGE
          There are uncommitted files:
          M lib/gem_comet.rb
          M lib/gem_comet/release.rb
          ?? lib/gem_comet/verify_git_condition.rb
          ?? spec/lib/gem_comet/verify_git_condition_spec.rb
        MESSAGE
      end

      it { expect { execute }.to raise_error(error_message.chomp) }
    end

    context 'when unexists uncommitted files' do
      let(:uncommitted_files) { [] }

      context 'when the current branch is different from the base branch' do
        let(:current_branch) { 'another-branch' }

        let(:message) do
          <<~STDOUT
            Current branch is expected to 'master', but 'another-branch'.
            Checkout to 'master'.
          STDOUT
        end

        it 'executes git checkout then git pull' do
          expect { execute }.to output(message).to_stdout
          expect(git_command).to have_received(:checkout).with('master').ordered
          expect(git_command).to have_received(:pull).ordered
        end
      end

      context 'when the current branch is equal to the base branch' do
        it 'executes git pull' do
          execute
          expect(git_command).not_to have_received(:checkout)
          expect(git_command).to have_received(:pull).ordered
        end
      end
    end
  end
end
