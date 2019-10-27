# frozen_string_literal: true

RSpec.describe GemComet::Changelog::Initializer do
  before do
    allow(GemComet::Changelog::Editor).to receive(:new).and_return(changelog_editor)
    allow(GemComet::Changelog::Generator).to receive(:call) { |arg| "#{arg[:version]} changelog" }
    allow(GemComet::VersionHistory).to receive(:new).and_return(version_history)
  end

  let(:changelog_editor) { instance_double(GemComet::Changelog::Editor, prepend!: nil) }
  let(:version_history) { instance_double(GemComet::VersionHistory, versions: versions) }
  let(:versions) { %w[v0.1.0 v0.1.1 v0.1.2] }

  describe '.call' do
    subject(:initialization) { described_class.call }

    # rubocop:disable RSpec/ExampleLength
    it 'appends past version change-logs to the CHANGELOG.md' do
      initialization
      expect(GemComet::Changelog::Generator)
        .to have_received(:call).with(version: 'v0.1.0').ordered
      expect(changelog_editor)
        .to have_received(:prepend!).with(content: 'v0.1.0 changelog').ordered
      expect(GemComet::Changelog::Generator)
        .to have_received(:call).with(version: 'v0.1.1').ordered
      expect(changelog_editor)
        .to have_received(:prepend!).with(content: 'v0.1.1 changelog').ordered
      expect(GemComet::Changelog::Generator)
        .to have_received(:call).with(version: 'v0.1.2').ordered
      expect(changelog_editor)
        .to have_received(:prepend!).with(content: 'v0.1.2 changelog').ordered
    end
    # rubocop:enable RSpec/ExampleLength
  end
end
