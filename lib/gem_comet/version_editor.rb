# frozen_string_literal: true

module GemComet
  # Edits version file of the gem
  class VersionEditor
    attr_reader :version_file_path

    VERSION_NUMBER_PATTERN = /VERSION\s*=\s*(['"])(.+?)(['"])/.freeze

    def initialize
      @version_file_path = Config.call.release.version_file_path
    end

    # Reads the current version number of gem
    #
    # @return [String] The current version number
    def current_version
      version_file = File.read(version_file_path)
      VERSION_NUMBER_PATTERN.match(version_file).captures[1]
    end

    # Updates the version number of gem
    #
    # @param new_version [String] The next version number
    def update!(new_version:)
      version_file = File.read(version_file_path)
      version_file.sub!(VERSION_NUMBER_PATTERN, "VERSION = \\1#{new_version}\\3")
      File.write(version_file_path, version_file)
    end
  end
end
