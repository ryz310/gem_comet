# frozen_string_literal: true

module GemComet
  # Edits CHANGELOG.md file of gem
  class ChangelogEditor
    HEADER = "# Change log\n"

    attr_reader :changelog_file_path

    def initialize
      @changelog_file_path = Config.call.release.changelog_file_path
    end

    # Prepends the content to CHANGELOG.md.
    #
    # @param content [String] Character string you want to prepend
    def prepend!(content:)
      return if changelog_file_path.nil?

      modify_changelog do |changelog_file|
        position = changelog_file.index(HEADER) + HEADER.length
        changelog_file.insert(position, content)
      end
    end

    # Appends the content to CHANGELOG.md.
    #
    # @param content [String] Character string you want to append
    def append!(content:)
      return if changelog_file_path.nil?

      modify_changelog do |changelog_file|
        changelog_file.concat(content)
      end
    end

    private

    def modify_changelog
      changelog_file = File.read(changelog_file_path)
      yield(changelog_file)
      File.write(changelog_file_path, changelog_file)
    end
  end
end
