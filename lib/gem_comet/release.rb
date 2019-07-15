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
      update_pr = PrComet.new(base: base_branch, branch: "update/v#{version}")
      release_pr = PrComet.new(base: release_branch, branch: base_branch)

      # Modify your version file
      update_pr.commit ':comet: Update version number' do
        gsub_file config['version_file_path'],
                  /VERSION\s*=\s*(['"])(.+?)(['"])/,
                  "VERSION = \\1#{version}\\3"
      end

      # Bundle Update
      update_pr.commit(':comet: $ bundle update') { `bundle update` }

      update_pr.create!(title: "Update v#{version}", body: '')
      release_pr.create!(title: "Release v#{version}", body: '', validate: false)
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
