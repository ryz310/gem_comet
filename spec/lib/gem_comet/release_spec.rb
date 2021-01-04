# frozen_string_literal: true

RSpec.describe GemComet::Release do
  before do
    allow(GemComet::VerifyGitCondition).to receive(:call)
    allow(GemComet::Release::CreateUpdatePR).to receive(:call)
    allow(GemComet::Release::CreateReleasePR).to receive(:call)
    allow(GemComet::OpenGithubPullsPage).to receive(:call)
  end

  describe '.call' do
    subject(:release) { described_class.call(version: '1.2.3') }

    it 'executes gem release flow' do # rubocop:disable RSpec/ExampleLength
      release
      expect(GemComet::VerifyGitCondition)
        .to have_received(:call).ordered
      expect(GemComet::Release::CreateUpdatePR)
        .to have_received(:call)
        .with(version: '1.2.3', base_branch: 'master').ordered
      expect(GemComet::Release::CreateReleasePR)
        .to have_received(:call)
        .with(version: '1.2.3', base_branch: 'master', release_branch: 'release').ordered
      expect(GemComet::OpenGithubPullsPage)
        .to have_received(:call).ordered
    end
  end
end
