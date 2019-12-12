# frozen_string_literal: true

module GemComet
  class Release
    # Creates a pull request for release preparation
    class CreateUpdatePR < ServiceAbstract
      def initialize(version:, base_branch:)
        @version = version
        @pr_comet = PrComet.new(base: base_branch, branch: "update/v#{version}")
        @version_editor = VersionEditor.new
        @prev_version = version_editor.current_version
        @changelog_editor = Changelog::Editor.new
      end

      private

      attr_reader :version, :prev_version, :pr_comet, :version_editor, :changelog_editor

      def call
        update_changelog
        update_version_file
        bundle_update
        create_pull_request
      end

      def update_changelog
        pr_comet.commit ':comet: Update CHANGELOG.md' do
          changelog = Changelog::Generator.call(version: 'HEAD', title: "v#{version}")
          changelog_editor.prepend!(content: changelog)
        end
      end

      def update_version_file
        pr_comet.commit ':comet: Update version number' do
          version_editor.update!(new_version: version)
        end
      end

      def bundle_update
        pr_comet.commit(':comet: $ bundle update') { BundleUpdater.call }
      end

      def create_pull_request
        pr_comet.create!(title: "Update v#{version}", body: pull_request_body)
      end

      def pull_request_body
        template = File.read(template_file_path)
        ERB.new(template, nil, '-').result(binding)
      end

      def template_file_path
        File.expand_path('../../../template/update_pr.md.erb', __dir__)
      end
    end
  end
end
