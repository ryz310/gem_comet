# frozen_string_literal: true

module GemComet
  # Reads versions by `git tag` command
  class VersionHistory
    def initialize
      @array_of_version_and_date = git_tag_list.lines.map(&:chomp).map(&:split).sort_by(&:last)
    end

    # Get all version numbers
    #
    # @return [Array<String>] An array of version numbers
    def versions
      array_of_version_and_date.map(&:first)
    end

    # Get a previous version number from the specified version number
    #
    # @param version [String] Any version number
    # @return [String] A previous version number
    # @raise [RuntimeError] The specified version cannot be found
    def previous_version_from(version)
      index = versions.index(version)
      raise 'The specified version cannot be found' if index.nil?
      return nil if index.zero?

      versions.at(index - 1)
    end

    private

    attr_reader :array_of_version_and_date

    # Executes `git tag` command
    #
    # @return [String] Output result
    def git_tag_list
      `git tag --list 'v*' --format='%(tag) %(taggerdate:short)'`
    end
  end
end
