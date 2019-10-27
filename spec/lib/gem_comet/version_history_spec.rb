# frozen_string_literal: true

RSpec.describe GemComet::VersionHistory do
  let(:instance) { described_class.new }
  let(:git_tag_result) do
    <<~RESULT
      v0.1.0 2019-07-15
      v0.1.1 2019-10-13
      v0.2.0 2019-10-14
      v0.3.0 2019-10-19
    RESULT
  end

  before do
    allow(instance).to receive(:git_tag_list).and_return(git_tag_result)
  end

  describe '#versions' do
    it 'returns an array of version numbers' do
      expect(instance.versions).to eq %w[v0.1.0 v0.1.1 v0.2.0 v0.3.0 HEAD]
    end
  end

  describe '#previous_version_from' do
    subject(:previous_version) { instance.previous_version_from(version) }

    context 'with the first version number' do
      let(:version) { 'v0.1.0' }

      it { is_expected.to be_nil }
    end

    context 'with "v0.2.0", which is the next version of "v0.1.1"' do
      let(:version) { 'v0.2.0' }

      it { is_expected.to eq 'v0.1.1' }
    end

    context 'with a wrong version number' do
      let(:version) { 'xxx' }

      it { expect { previous_version }.to raise_error 'The specified version cannot be found' }
    end
  end

  describe '#versioning_date_of' do
    subject(:versioning_date) { instance.versioning_date_of(version) }

    context 'with "HEAD"' do
      let(:version) { 'HEAD' }

      it { is_expected.to eq Date.today }
    end

    context 'with "v0.2.0", which added at 2019-10-14' do
      let(:version) { 'v0.2.0' }

      it { is_expected.to eq Date.new(2019, 10, 14) }
    end

    context 'with a wrong version number' do
      let(:version) { 'xxx' }

      it { expect { versioning_date }.to raise_error 'The specified version cannot be found' }
    end
  end
end
