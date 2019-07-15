# frozen_string_literal: true

require 'thor'

module GemComet
  # CLI commands definition
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__)
    end

    desc 'init', 'Creates a configure file'
    def init
      template '../../template/.gem_comet.yml.erb', '.gem_comet.yml',
               version: GemComet::VERSION
    end

    desc 'release VERSION', 'Creates update PR and release PR'
    def release(version)
      verify_version_number(version)

      config = YAML.safe_load(open('.gem_comet.yml'))['release']
      update_pr = PrComet.new(base: config['base_branch'], branch: "update/v#{version}")
      release_pr = PrComet.new(base: config['release_branch'], branch: config['base_branch'])

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

    desc 'version', 'Shows current version'
    def version
      puts GemComet::VERSION
    end

    private

    def verify_version_number(version)
      return if version.match?(/\A\d+\.\d+\.\d+(\.(pre|beta|rc)\d?)?\z/)

      raise 'Verion number must be like a "1.2.3"'
    end
  end
end
