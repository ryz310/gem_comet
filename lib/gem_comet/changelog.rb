# frozen_string_literal: true

module GemComet
  # Generates changelog from git log
  class Changelog < ServiceAbstract
    # @param from_version [String]
    #   The beginning of version number to create a changelog.
    #   Default is specified current version.
    # @param to_version [String]
    #   The end of version number to create a changelog.
    #   Default is specified `HEAD`.
    # @param append [Boolean]
    #   Appends execution result to CHANGELOG.md.
    # @param prepend [Boolean]
    #   Prepends execution result to CHANGELOG.md.
    def initialize(from_version: nil, to_version: nil, append: false, prepend: false)
      @version_editor = VersionEditor.new
      @changelog_editor = Changelog::Editor.new
      @from_version = from_version || version_editor.current_version
      @to_version = to_version
      @append = append
      @prepend = prepend
    end

    private

    attr_reader :version_editor, :changelog_editor,
                :from_version, :to_version, :append, :prepend

    # Displays changelogs. If specified a `append` or `prepend` option, updates
    # CHANGELOG.md with generated changelog.
    #
    # @return [String] Ganalated changelog
    def call
      if append
        changelog_editor.append!(content: changelog)
      elsif prepend
        changelog_editor.prepend!(content: changelog)
      end
      changelog
    end

    # Generate a changelog. The result is memoized.
    #
    # @return [String] Ganalated changelog
    def changelog
      @changelog ||= Generator.call(from_version: from_version, to_version: to_version)
    end
  end
end
