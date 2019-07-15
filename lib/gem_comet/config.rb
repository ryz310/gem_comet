# frozen_string_literal: true

module GemComet
  # Loads the config file
  class Config < ServiceAbstract
    FILE_PATH = '.gem_comet.yml'

    Version0_1_0 = TypeStruct.new(
      version: '0.1.0',
      release: TypeStruct.new(
        base_branch: String,
        release_branch: String,
        version_file_path: String
      )
    )

    private

    def initialize; end

    def call
      Version0_1_0.from_hash(YAML.safe_load(File.open(FILE_PATH)))
    rescue Errno::ENOENT
      raise 'Not initialized. Please run `$ gem_comet init`.'
    rescue TypeStruct::MultiTypeError => e
      puts e.message
      raise "Unexpected file format. Please check your '#{FILE_PATH}'."
    end
  end
end
