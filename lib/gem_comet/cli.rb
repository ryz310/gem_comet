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

    desc 'changelog', 'Displays changelogs from last release to HEAD commit'
    option :from,
           type: :string,
           aliases: :f,
           desc: 'The beginning of version number to create a changelog. ' \
                 'Default is specified current version.'
    option :to,
           type: :string,
           aliases: :t,
           desc: 'The end of version number to create a changelog. ' \
                 'Default is specified `HEAD`.'
    def changelog
      version_editor = VersionEditor.new
      from_version = options[:from] || version_editor.current_version
      to_version = options[:to]
      puts ChangelogGenerator.call(from_version: from_version, to_version: to_version)
    end

    desc 'version', 'Shows current version'
    def version
      puts GemComet::VERSION
    end
  end
end
