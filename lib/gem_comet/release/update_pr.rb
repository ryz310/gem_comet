# frozen_string_literal: true

module GemComet
  class Release
    # Creates a pull request for release preparation
    class UpdatePR < ServiceAbstract
      private

      attr_reader :version, :pr_comet

      def initialize(version:, base_branch:)
        @version = version
        @pr_comet = PrComet.new(base: base_branch, branch: "update/v#{version}")
      end

      def call
        update_version_file
        bundle_update
        create_pull_request
      end

      def update_version_file
        pr_comet.commit ':comet: Update version number' do
          gsub_file config['version_file_path'],
                    /VERSION\s*=\s*(['"])(.+?)(['"])/,
                    "VERSION = \\1#{version}\\3"
        end
      end

      def bundle_update
        pr_comet.commit(':comet: $ bundle update') { `bundle update` }
      end

      def create_pull_request
        pr_comet.create!(title: "Update v#{version}", body: '')
      end
    end
  end
end
