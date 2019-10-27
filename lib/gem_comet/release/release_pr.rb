# frozen_string_literal: true

module GemComet
  class Release
    # Creates a pull request for your gem release
    class ReleasePR < ServiceAbstract
      private

      attr_reader :version, :pr_comet

      def initialize(version:, base_branch:, release_branch:)
        @version = version
        @pr_comet = PrComet.new(base: release_branch, branch: base_branch)
      end

      def call
        create_pull_request
      end

      def create_pull_request
        pr_comet.create!(title: "Release v#{version}", body: LEGEND, validate: false)
      end
    end
  end
end
