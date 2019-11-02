# frozen_string_literal: true

module GemComet
  class Changelog
    # Generates changelog from git log
    class Generator < ServiceAbstract
      attr_reader :version, :title, :origin_url

      # @param version [String] The end of version number to create a changelog.
      # @param title [String] Next version of your gem
      def initialize(version:, title: nil)
        @version = version
        @title = title || version
        @origin_url = RepositoryUrl.call
      end

      private

      MERGE_COMMIT_TITLE = /Merge pull request #(\d+) from (.+)/.freeze
      AUTHOR_NAME = /<(.+?)@users\.noreply\.github\.com>/.freeze

      # Returns changelogs as markdown format from current version to HEAD commit.
      #
      # @return [String] Changelogs as markdown format
      # @raise [RuntimeError] The specified version cannot be found
      def call
        <<~MARKDOWN

          ## #{title} (#{versioning_date})

          ### Feature
          ### Bugfix
          ### Breaking Change
          ### Misc

          #{changelogs.reverse.join("\n")}
        MARKDOWN
      end

      # Returns the versioning date
      #
      # @return [String] The versioning date. e.g. "Oct 26, 2019"
      def versioning_date
        VersionHistory.new.versioning_date_of(version).strftime('%b %d, %Y')
      end

      # Returns array of changelogs as markdown format.
      #
      # @return [Array<String>] Array of changelogs as markdown format
      def changelogs
        merge_commits.map do |merge_commit|
          next unless merge_commit.match?(MERGE_COMMIT_TITLE)

          number = extract_pull_request_number(merge_commit)
          title = extract_description(merge_commit) || extract_branch_name(merge_commit)
          author = extract_author_name(merge_commit)

          generate_changelog(number, title, author)
        end.compact
      end

      # Generates changelog message as markdown list
      #
      # @param number [Integer] The pull request number
      # @param title [String] The pull request title
      # @param author [String] The author of the PR
      # @return [String] Changelog message as markdown list
      def generate_changelog(number, title, author)
        [
          '*',
          "[##{number}](#{get_pull_request_url(number)})",
          title,
          "([@#{author}](https://github.com/#{author}))"
        ].join(' ')
      end

      # Extracts PR number from merge commit string.
      #
      # @param merge_commit [String] The target string
      # @return [Integer] The pull request number
      def extract_pull_request_number(merge_commit)
        MERGE_COMMIT_TITLE.match(merge_commit).captures.first.to_i
      end

      # Get the PR URL. (e.g. https://github.com/ryz310/gem_comet/pull/1)
      #
      # @param pull_request_number [Integer] The target pull request number
      # @return [String] Returns the URL
      def get_pull_request_url(pull_request_number)
        "#{origin_url}/pull/#{pull_request_number}"
      end

      # Extracts commit desciption from merge commit string.
      #
      # @param merge_commit [String] The target string
      # @return [String] The commit description
      # @return [nil] Returns `nil` if not exists
      def extract_description(merge_commit)
        description = merge_commit.lines.last
        description&.chomp&.strip unless description.match?(MERGE_COMMIT_TITLE)
      end

      # Extracts the PR branch name from merge commit string.
      #
      # @param merge_commit [String] The target string
      # @return [String] Branch name
      def extract_branch_name(merge_commit)
        MERGE_COMMIT_TITLE.match(merge_commit).captures.last.chomp.strip
      end

      # Extracts the author of the PR from merge commit string.
      #
      # @param merge_commit [String] The target string
      # @return [String] Author name
      def extract_author_name(merge_commit)
        AUTHOR_NAME.match(merge_commit).captures.first
      end

      # Parces the merge commit log, which to separate by each commit.
      #
      # @return [Array<String>] Array of git commit log
      def merge_commits
        merge_commit_log.split(/^commit \w{40}\n/).reject(&:empty?).map(&:chomp)
      end

      # Returns only merge commit logs via git command.
      #
      # @return [String] Get only merge commit logs
      def merge_commit_log
        @merge_commit_log ||= `git log --merges #{prev_version}..#{version}`
      end

      # Get a previous version number from the specified version number
      #
      # @raise [RuntimeError] The specified version cannot be found
      def prev_version
        @prev_version ||= VersionHistory.new.previous_version_from(version)
      end
    end
  end
end
