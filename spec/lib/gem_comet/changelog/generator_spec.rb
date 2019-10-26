# frozen_string_literal: true

RSpec.describe GemComet::Changelog::Generator do
  describe '.call' do
    context 'with title' do
      subject { described_class.call(version: 'v0.3.0', title: 'TITLE') }

      let(:expected_result) do
        <<~MARKDOWN

          ## TITLE (Oct 19, 2019)

          ### Feature
          ### Bugfix
          ### Breaking Change
          ### Misc

          * Re-generate .rubocop_todo.yml with RuboCop v0.75.1 ([#25](https://github.com/ryz310/gem_comet/pull/25))
          * Enhance the feature of changelog command ([#27](https://github.com/ryz310/gem_comet/pull/27))
          * Update v0.3.0 ([#30](https://github.com/ryz310/gem_comet/pull/30))
          * Release v0.3.0 ([#31](https://github.com/ryz310/gem_comet/pull/31))
        MARKDOWN
      end

      it { is_expected.to eq expected_result }
    end

    context 'without title' do
      subject { described_class.call(version: 'v0.3.0') }

      let(:expected_result) do
        <<~MARKDOWN

          ## v0.3.0 (Oct 19, 2019)

          ### Feature
          ### Bugfix
          ### Breaking Change
          ### Misc

          * Re-generate .rubocop_todo.yml with RuboCop v0.75.1 ([#25](https://github.com/ryz310/gem_comet/pull/25))
          * Enhance the feature of changelog command ([#27](https://github.com/ryz310/gem_comet/pull/27))
          * Update v0.3.0 ([#30](https://github.com/ryz310/gem_comet/pull/30))
          * Release v0.3.0 ([#31](https://github.com/ryz310/gem_comet/pull/31))
        MARKDOWN
      end

      it { is_expected.to eq expected_result }
    end
  end
end
