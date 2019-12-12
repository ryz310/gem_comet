# frozen_string_literal: true

module GemComet
  class Release
    # Creates a pull request for your gem release
    class CreateReleasePR < ServiceAbstract
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
        pr_comet.create!(
          title: "Release v#{version}",
          body: pull_request_body,
          validate: false
        )
      end

      def pull_request_body
        template = File.read(template_file_path)
        ERB.new(template, nil, '-').result(binding)
      end

      def template_file_path
        File.expand_path('../../../template/release_pr.md.erb', __dir__)
      end
    end
  end
end
