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
      version_editor = VersionEditor.new
      from_version = options[:from] || version_editor.current_version
      to_version = options[:to]
      result = ChangelogGenerator.call(from_version: from_version, to_version: to_version)
      changelog_editor = ChangelogEditor.new
      case
      when options[:append]
        changelog_editor.append!(content: result)
      when options[:prepend]
        changelog_editor.prepend!(content: result)
      else
        puts result
      end
    end

    desc 'versions', 'Displays version numbers of your gem.'
    def versions
      puts `git tag`
    end

    desc 'version', 'Shows current version'
    def version
      puts GemComet::VERSION
    end
  end
end
