# frozen_string_literal: true

module GemComet
  # Loads the config file
  class Config < ServiceAbstract
    using TypeStruct::Union::Ext

    CURRENT_VERSION = 1.1

    V1_1 = TypeStruct.new(
      version: CURRENT_VERSION,
      release: TypeStruct.new(
        base_branch: String,
        release_branch: String,
        version_file_path: String,
        changelog_file_path: String | nil
      )
    )

    private

    attr_reader :file_path

    def initialize(file_path:)
      @file_path = file_path
    end

    def call
      V1_1.from_hash(YAML.safe_load(File.open(file_path)))
    rescue Errno::ENOENT
      raise 'Not initialized. Please run `$ gem_comet init`.'
    rescue TypeStruct::MultiTypeError => e
      puts e.message
      raise "Unexpected file format. Please check your '#{file_path}'."
    end
  end
end
