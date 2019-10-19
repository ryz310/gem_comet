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

    desc 'changelog', 'Displays changelogs'
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
      puts Changelog.call(
        from_version: options[:from],
        to_version: options[:to],
        append: options[:append],
        prepend: options[:prepend]
      )
    end

    desc 'versions', 'Displays version numbers of your gem.'
    def versions
      tags = `git tag --list 'v*' --format='%(tag) %(taggerdate:short)'`
      puts tags.lines.map(&:chomp).map(&:split).sort_by(&:last).map(&:first)
    end

    desc 'version', 'Shows current version'
    def version
      puts GemComet::VERSION
    end
  end
end
