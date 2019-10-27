# frozen_string_literal: true

RSpec.describe GemComet::RepositoryUrl do
  describe '.call' do
    subject { described_class.call }

    before do
      allow_any_instance_of(described_class)
        .to receive(:git_remote_command).and_return(output_result)
    end

    context 'when the remote URL registered for using HTTPS' do
      let(:output_result) { 'https://github.com/ryz310/gem_comet.git' }

      it { is_expected.to eq 'https://github.com/ryz310/gem_comet' }
    end

    context 'when the remote URL registered for using SSH' do
      let(:output_result) { 'git@github.com:ryz310/gem_comet.git' }

      it { is_expected.to eq 'https://github.com/ryz310/gem_comet' }
    end
  end
end
