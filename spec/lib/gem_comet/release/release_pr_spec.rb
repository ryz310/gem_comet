# frozen_string_literal: true

RSpec.describe GemComet::Release::ReleasePR do
  let!(:pr_comet) do
    instance_double(PrComet, create!: true).tap do |instance|
      allow(instance).to receive(:commit) { |_message, &block| block&.call }
      allow(PrComet).to receive(:new).and_return(instance)
    end
  end

  describe '.call' do
    subject(:release_pr) do
      described_class.call(version: '1.2.3', base_branch: 'master', release_branch: 'release')
    end

    it 'creates a pull request to release the gem' do
      release_pr
      expect(PrComet).to have_received(:new)
        .with(base: 'release', branch: 'master').ordered
      expect(pr_comet).to have_received(:create!)
        .with(title: 'Release v1.2.3', body: GemComet::LEGEND, validate: false).ordered
    end
  end
end
