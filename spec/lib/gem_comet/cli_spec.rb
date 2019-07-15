# frozen_string_literal: true

RSpec.describe GemComet::CLI do
  let(:cli) { described_class.new }

  describe '#init' do
    before { allow(cli).to receive(:template) }

    it do
      cli.init
      expect(cli).to have_received(:template)
    end
  end

  describe '#version' do
    it { expect { cli.version }.to output("#{GemComet::VERSION}\n").to_stdout }
  end
end
