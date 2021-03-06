# frozen_string_literal: true

module GemComet
  # Loads the config file
  class Config < ServiceAbstract
    using TypeStruct::Union::Ext

    CONFIG_FILE_PATH = '.gem_comet.yml'
    CURRENT_VERSION = 1.2

    Release = TypeStruct.new(
      base_branch: String,
      release_branch: String,
      version_file_path: String,
      changelog_file_path: String | nil
    )

    Changelog = TypeStruct.new(
      categories: TypeStruct::ArrayOf.new(String)
    )

    V1_2 = TypeStruct.new(
      version: 1.0...2.0,
      release: Release,
      changelog: Changelog | nil
    )

    def initialize; end

    private

    def call
      V1_2.from_hash(YAML.safe_load(File.open(CONFIG_FILE_PATH)))
    rescue Errno::ENOENT
      raise 'Not initialized. Please run `$ gem_comet init`.'
    rescue TypeStruct::MultiTypeError => e
      puts e.message
      raise "Unexpected file format. Please check your '#{CONFIG_FILE_PATH}'."
    end
  end
end
