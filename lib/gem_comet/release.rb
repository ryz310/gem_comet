# frozen_string_literal: true

module GemComet
  class Release
    attr_reader :version, :base_branch, :release_branch

    CONFIG_FILE_PATH = '.gem_comet.yml'

    def self.call(*args)
      new(*args).send(:call)
    end

    private

    def initialize(version:)
      verify_version_number(version)

      @version = version
      @base_branch = config['base_branch']
      @release_branch = config['release_branch']
    end

    def call
      UpdatePR.call(version: version, base_branch: base_branch)
      ReleasePR.call(version: version, base_branch: base_branch, release_branch: release_branch)
    end

    def config
      @config ||= YAML.safe_load(File.open(CONFIG_FILE_PATH))['release']
    rescue Errno::ENOENT
      raise 'Not initialized. Please run `$ gem_comet init`.'
    end

    def verify_version_number(version)
      return if version.match?(/\A\d+\.\d+\.\d+(\.(pre|beta|rc)\d?)?\z/)

      raise 'Verion number must be like a "1.2.3".'
    end
  end
end
