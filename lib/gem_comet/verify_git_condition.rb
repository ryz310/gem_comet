# frozen_string_literal: true

module GemComet
  # Verifies current git branch condition
  class VerifyGitCondition < ServiceAbstract
    def initialize
      @base_branch = Config.call.release.base_branch
      @git_command = GitCommand.new
    end

    private

    attr_reader :base_branch, :git_command

    def call
      verify_git_status
      checkout_to_base_branch!
      git_pull!
    end

    # Verifies that there are not uncommitted files
    #
    # @raise [RuntimeError] Exists uncommitted files
    def verify_git_status
      uncommitted_files = git_command.uncommitted_files
      return if uncommitted_files.empty?

      raise "There are uncommitted files:\n#{uncommitted_files.join("\n")}"
    end

    # Checkout to the base branch
    def checkout_to_base_branch!
      current_branch = git_command.current_branch
      return if base_branch == current_branch

      puts "Current branch is expected to '#{base_branch}', but '#{current_branch}'."
      puts "Checkout to '#{base_branch}'."
      git_command.checkout(base_branch)
    end

    def git_pull!
      git_command.pull
    end
  end
end
