# frozen_string_literal: true

module GemComet
  # Reads versions by `git tag` command
  class VersionHistory
    # Gets all version numbers
    #
    # @return [Array<String>] An array of version numbers
    def versions
      array_of_version_and_date.map(&:first).push('HEAD')
    end

    # Gets a previous version number from the specified version number
    #
    # @param version [String] Any version number
    # @return [String] A previous version number
    # @raise [RuntimeError] The specified version cannot be found
    def previous_version_from(version)
      index = find_version_index(version)
      return nil if index.zero?

      versions.at(index - 1)
    end

    # Gets the verioning date of the version number
    #
    # @param version [String] Any version number
    # @return [Date] The verioning date
    # @raise [RuntimeError] The specified version cannot be found
    def versioning_date_of(version)
      return Date.today if version == 'HEAD'

      index = find_version_index(version)
      Date.parse(array_of_version_and_date[index].last)
    end

    private

    # Processes `git tag` command result
    #
    # @return [Array<Array<String>>] An array of versions and date
    #   e.g. [['v0.1.0', '2019-07-15'], ['v0.2.0', '2019-10-14']]
    def array_of_version_and_date
      @array_of_version_and_date ||= git_tag_list.lines.map(&:chomp).map(&:split).sort_by(&:last)
    end

    # Finds an index of the specified version number
    #
    # @param version [String] Any version number
    # @return [Integer] The index of the specified version number
    # @raise [RuntimeError] The specified version cannot be found
    def find_version_index(version)
      index = versions.index(version)
      raise 'The specified version cannot be found' if index.nil?

      index
    end

    # Executes `git tag` command
    #
    # @return [String] Output result
    def git_tag_list
      `git tag --list 'v*' --format='%(tag) %(taggerdate:short)'`
    end
  end
end
