# frozen_string_literal: true

module GemComet
  # Generates changelog from git log
  class Changelog < ServiceAbstract
    attr_reader :last_label

    def initialize(last_label:)
      @last_label = last_label
    end

    private

    MERGE_COMMIT_TITLE = /Merge pull request #(\d+) from (.+)/.freeze

    def call
      merge_commits.map do |merge_commit|
        next unless merge_commit.match?(MERGE_COMMIT_TITLE)

        pull_request_number = extract_pull_request_number(merge_commit)
        pull_request_url = get_pull_request_url(pull_request_number)
        description = extract_description(merge_commit) || extract_branch_name(merge_commit)

        "* #{description} ([##{pull_request_number}](#{pull_request_url}))"
      end.reverse.compact.join("\n")
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
      @merge_commit_log ||= `git log --merges #{last_label}..HEAD`
    end

    # Returns the git origin URL via git command.
    #
    # @return [String] The origin URL
    def origin_url
      @origin_url ||= `git remote get-url --push origin`.sub('.git', '').chomp
    end
  end
end
