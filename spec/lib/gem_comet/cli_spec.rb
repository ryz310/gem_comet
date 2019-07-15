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

  describe '#release' do
    subject(:release!) { cli.release version }

    context 'with valid version number' do
      let(:version) { '1.2.3' }
      let(:pr_comet) { instance_double(PrComet, commit: nil, create!: nil) }

      before { allow(PrComet).to receive(:new).and_return(pr_comet) }

      it 'executes commit and PR creation' do
        release!
        expect(pr_comet).to have_received(:commit).twice
        expect(pr_comet).to have_received(:create!).twice
      end
    end

    context 'with invalid version number' do
      let(:version) { '1,2,3' }

      it do
        expect { release! }.to raise_error(/Verion number must be like a "1.2.3"/)
      end
    end
  end

  describe '#version' do
    it { expect { cli.version }.to output("#{GemComet::VERSION}\n").to_stdout }
  end
end
