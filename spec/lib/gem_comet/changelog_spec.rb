# frozen_string_literal: true

RSpec.describe GemComet::Changelog do
  before do
    allow(GemComet::Changelog::Editor).to receive(:new).and_return(changelog_editor)
    allow(GemComet::Changelog::Generator).to receive(:call).and_return(changelog)
  end

  let(:changelog_editor) do
    instance_double(GemComet::Changelog::Editor, append!: nil, prepend!: nil)
  end
  let(:changelog) { 'changelog' }

  describe '.call' do
    subject(:call_service) do
      described_class.call(version: version, append: append, prepend: prepend)
    end

    let(:version) { 'v1.2.3' }
    let(:append) { false }
    let(:prepend) { false }

    shared_examples 'to generate changelogs' do
      it 'returns changelogs' do
        expect(call_service).to eq changelog
      end

      it 'calls the changelog generator service class with the specified version number' do
        call_service
        expect(GemComet::Changelog::Generator).to have_received(:call).with(version: version)
      end
    end

    describe 'when `append` and `prepend` options are false' do
      it_behaves_like 'to generate changelogs'

      it 'does not modify CHANGELOG.md' do
        call_service
        expect(changelog_editor).not_to have_received(:append!).with(content: changelog)
        expect(changelog_editor).not_to have_received(:prepend!).with(content: changelog)
      end
    end

    describe 'when `append` is true' do
      let(:append) { true }

      it_behaves_like 'to generate changelogs'

      it 'appends changelogs to the CHANGELOG.md' do
        call_service
        expect(changelog_editor).to have_received(:append!).with(content: changelog)
        expect(changelog_editor).not_to have_received(:prepend!).with(content: changelog)
      end
    end

    describe 'when `prepend` is true' do
      let(:prepend) { true }

      it_behaves_like 'to generate changelogs'

      it 'appends changelogs to the CHANGELOG.md' do
        call_service
        expect(changelog_editor).not_to have_received(:append!).with(content: changelog)
        expect(changelog_editor).to have_received(:prepend!).with(content: changelog)
      end
    end
  end
end
