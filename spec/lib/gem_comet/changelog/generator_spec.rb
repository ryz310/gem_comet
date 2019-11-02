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

          * [#25](https://github.com/ryz310/gem_comet/pull/25) Re-generate .rubocop_todo.yml with RuboCop v0.75.1 ([@ryz310](https://github.com/ryz310))
          * [#27](https://github.com/ryz310/gem_comet/pull/27) Enhance the feature of changelog command ([@ryz310](https://github.com/ryz310))
          * [#30](https://github.com/ryz310/gem_comet/pull/30) Update v0.3.0 ([@ryz310](https://github.com/ryz310))
          * [#31](https://github.com/ryz310/gem_comet/pull/31) Release v0.3.0 ([@ryz310](https://github.com/ryz310))
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

          * [#25](https://github.com/ryz310/gem_comet/pull/25) Re-generate .rubocop_todo.yml with RuboCop v0.75.1 ([@ryz310](https://github.com/ryz310))
          * [#27](https://github.com/ryz310/gem_comet/pull/27) Enhance the feature of changelog command ([@ryz310](https://github.com/ryz310))
          * [#30](https://github.com/ryz310/gem_comet/pull/30) Update v0.3.0 ([@ryz310](https://github.com/ryz310))
          * [#31](https://github.com/ryz310/gem_comet/pull/31) Release v0.3.0 ([@ryz310](https://github.com/ryz310))
        MARKDOWN
      end

      it { is_expected.to eq expected_result }
    end
  end
end
