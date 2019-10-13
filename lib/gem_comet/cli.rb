# frozen_string_literal: true

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
               version: GemComet::Config::CURRENT_VERSION
      template '../../template/CHANGELOG.md.erb', 'CHANGELOG.md'
    end

    desc 'release VERSION', 'Creates update PR and release PR'
    def release(version)
      Release.call(version: version)
    end

    desc 'version', 'Shows current version'
    def version
      puts GemComet::VERSION
    end
  end
end
