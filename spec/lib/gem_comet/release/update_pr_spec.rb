# frozen_string_literal: true

RSpec.describe GemComet::Release::UpdatePR do
  before do
    allow(GemComet::VersionEditor).to receive(:new).and_return(version_editor)
    allow(GemComet::Changelog::Editor).to receive(:new).and_return(changelog_editor)
    allow(GemComet::Changelog::Generator).to receive(:call).and_return('changelog')
    allow(GemComet::BundleUpdater).to receive(:call)
  end

  let!(:pr_comet) do
    instance_double(PrComet, create!: true).tap do |instance|
      allow(instance).to receive(:commit) { |_message, &block| block&.call }
      allow(PrComet).to receive(:new).and_return(instance)
    end
  end
  let(:version_editor) { instance_double(GemComet::VersionEditor, update!: nil) }
  let(:changelog_editor) { instance_double(GemComet::Changelog::Editor, prepend!: nil) }

  describe '.call' do
    subject(:update_pr) { described_class.call(version: '1.2.3', base_branch: 'master') }

    # rubocop:disable RSpec/ExampleLength
    it 'updates the CHANGELOG, version file and dependent gems in ordered' do
      update_pr
      expect(GemComet::Changelog::Generator)
        .to have_received(:call).with(version: 'HEAD', title: 'v1.2.3').ordered
      expect(changelog_editor)
        .to have_received(:prepend!).with(content: 'changelog').ordered
      expect(version_editor)
        .to have_received(:update!).with(new_version: '1.2.3').ordered
      expect(GemComet::BundleUpdater)
        .to have_received(:call).with(no_args).ordered
    end

    it 'commits and creates a pull request to update gem version' do
      update_pr
      expect(PrComet)
        .to have_received(:new).with(base: 'master', branch: 'update/v1.2.3').ordered
      expect(pr_comet)
        .to have_received(:commit).with(':comet: Update CHANGELOG.md').ordered
      expect(pr_comet)
        .to have_received(:commit).with(':comet: Update version number').ordered
      expect(pr_comet)
        .to have_received(:commit).with(':comet: $ bundle update').ordered
      expect(pr_comet)
        .to have_received(:create!).with(title: 'Update v1.2.3', body: GemComet::LEGEND).ordered
    end
    # rubocop:enable RSpec/ExampleLength
  end
end