# frozen_string_literal: true

module GemComet
  class Release
    # Creates a pull request for release preparation
    class UpdatePR < ServiceAbstract
      def initialize(version:, base_branch:)
        @version = version
        @pr_comet = PrComet.new(base: base_branch, branch: "update/v#{version}")
        @version_editor = VersionEditor.new
        @changelog_editor = ChangelogEditor.new
      end

      private

      attr_reader :version, :pr_comet, :version_editor, :changelog_editor

      def call
        update_changelog
        update_version_file
        bundle_update
        create_pull_request
      end

      def update_changelog
        pr_comet.commit ':comet: Update CHANGELOG.md' do
          changelog = ChangelogGenerator.call(
            current_version: version_editor.current_version,
            new_version: version
          )
          changelog_editor.append!(content: changelog)
        end
      end

      def update_version_file
        pr_comet.commit ':comet: Update version number' do
          version_editor.update!(new_version: version)
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
