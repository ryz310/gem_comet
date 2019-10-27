# frozen_string_literal: true

module GemComet
  # Generates changelog from git log
  class Changelog < ServiceAbstract
    # @param version [String] The version number to create a changelog.
    # @param append [Boolean] Appends execution result to CHANGELOG.md.
    # @param prepend [Boolean] Prepends execution result to CHANGELOG.md.
    def initialize(version:, append: false, prepend: false)
      @changelog_editor = Changelog::Editor.new
      @version = version
      @append = append
      @prepend = prepend
    end

    private

    attr_reader :changelog_editor, :version, :append, :prepend

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
      @changelog ||= Generator.call(version: version)
    end
  end
end
