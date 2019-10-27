# frozen_string_literal: true

module GemComet
  class Changelog
    # Initializes the CHANGELOG.md to append past version change-logs
    class Initializer < ServiceAbstract
      def initialize
        @changelog_editor = Changelog::Editor.new
        @version_history = VersionHistory.new
      end

      private

      attr_reader :changelog_editor, :version_history

      def call
        version_history.versions.each do |version|
          changelog = Changelog::Generator.call(version: version)
          changelog_editor.prepend!(content: changelog)
        end
      end
    end
  end
end
