# frozen_string_literal: true

RSpec.describe GemComet::CLI do
  let(:cli) { described_class.new }

  describe '#init' do
    before do
      allow(cli).to receive(:template)
      allow(GemComet::Changelog::Initializer).to receive(:call)
    end

    it 'creates 2 template files and initializes the CHANGELOG.md' do
      cli.init
      expect(cli).to have_received(:template).twice.ordered
      expect(GemComet::Changelog::Initializer).to have_received(:call).ordered
    end
  end

  describe '#release' do
    subject(:release!) { cli.release version }

    context 'with valid version number' do
      let(:version) { '1.2.3' }

      before do
        stub_pr_comet!
        allow(GemComet::Release::UpdatePR).to receive(:call)
        allow(GemComet::Release::ReleasePR).to receive(:call)
        allow(GemComet::OpenGithubPullsPage).to receive(:call)
      end

      it 'creates update PR' do
        release!
        expect(GemComet::Release::UpdatePR)
          .to have_received(:call)
          .with(version: version, base_branch: 'master')
      end

      it 'creates release PR' do
        release!
        expect(GemComet::Release::ReleasePR)
          .to have_received(:call)
          .with(version: version, base_branch: 'master', release_branch: 'release')
      end

      it 'opens the GitHub pulls page' do
        release!
        expect(GemComet::OpenGithubPullsPage).to have_received(:call).with(no_args)
      end
    end

    context 'with invalid version number' do
      let(:version) { '1,2,3' }

      it do
        expect { release! }.to output(/Verion number must be like a "1.2.3"/).to_stdout
      end
    end
  end

  describe '#changelog' do
    before do
      allow(GemComet::Changelog).to receive(:call)
    end

    it do
      cli.changelog
      expect(GemComet::Changelog)
        .to have_received(:call).with(version: nil, append: nil, prepend: nil)
    end
  end

  describe '#version' do
    it { expect { cli.version }.to output("#{GemComet::VERSION}\n").to_stdout }
  end
end
