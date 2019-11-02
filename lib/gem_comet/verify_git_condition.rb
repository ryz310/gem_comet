# frozen_string_literal: true

module GemComet
  # Verifies current git branch condition
  class VerifyGitCondition < ServiceAbstract
    def initialize
      @base_branch = Config.call.release.base_branch
    end

    private

    attr_reader :base_branch

    def call
      raise "There are uncommitted files:\n#{uncommitted_files}" unless uncommitted_files.empty?

      checkout_to_base_branch!
      git_pull!
    end

    # Get uncommitted files
    #
    # @return [String] Uncommitted files
    def uncommitted_files
      @uncommitted_files ||= `git status --short`
    end

    # Get current git branch name
    #
    # @return [String] The current branch name
    def current_branch
      @current_branch ||= `git rev-parse --abbrev-ref HEAD`.chomp
    end

    # Checkout to the base branch
    def checkout_to_base_branch!
      return if base_branch == current_branch

      puts "Current branch is expected to #{base_branch}, but '#{current_branch}'."
      puts "Checkout to #{base_branch}."
      `git checkout #{base_branch}`
      @current_branch = base_branch
    end

    # Executes `$ git pull`
    def git_pull!
      `git pull`
    end
  end
end
