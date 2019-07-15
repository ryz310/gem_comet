# frozen_string_literal: true

module GemComet
  class Release
    # Creates a pull request for your gem release
    class ReleasePR
      attr_reader :version

      def self.call(*args)
        new(*args).send(:call)
      end

      private

      attr_reader :pr_comet

      def initialize(version:, base_branch:, release_branch:)
        @version = version
        @pr_comet = PrComet.new(base: release_branch, branch: base_branch)
      end

      def call
        create_pull_request
      end

      def create_pull_request
        pr_comet.create!(title: "Release v#{version}", body: '', validate: false)
      end
    end
  end
end
