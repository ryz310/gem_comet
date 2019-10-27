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
      Changelog::Initializer.call
    rescue StandardError => e
      puts e.message
    end

    desc 'release VERSION', 'Creates update PR and release PR'
    def release(version)
      Release.call(version: version)
    rescue StandardError => e
      puts e.message
    end

    desc 'changelog', 'Displays changelogs'
    option :version,
           type: :string,
           aliases: :v,
           default: 'HEAD',
           desc: 'The version number to create a changelog. ' \
                 'Default is specified `HEAD`.',
           banner: 'v1.2.3'
    option :append,
           type: :boolean,
           aliases: :a,
           default: false,
           desc: 'Appends execution result to CHANGELOG.md.'
    option :prepend,
           type: :boolean,
           aliases: :p,
           default: false,
           desc: 'Prepends execution result to CHANGELOG.md.'
    def changelog
      puts Changelog.call(
        version: options[:version],
        append: options[:append],
        prepend: options[:prepend]
      )
    rescue StandardError => e
      puts e.message
    end

    desc 'versions', 'Displays version numbers of your gem.'
    def versions
      puts VersionHistory.new.versions
    rescue StandardError => e
      puts e.message
    end

    desc 'version', 'Shows current version'
    def version
      puts GemComet::VERSION
    end
  end
end
