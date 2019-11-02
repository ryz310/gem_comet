# frozen_string_literal: true

module GemComet
  # Executes git command
  class GitCommand
    def initialize; end

    # Get uncommitted files
    #
    # @return [Array<String>] Uncommitted files
    def uncommitted_files
      git_status_short.lines.map(&:chomp)
    end

    # Get current git branch name
    #
    # @return [String] The current branch name
    def current_branch
      run 'rev-parse', '--abbrev-ref', 'HEAD'
    end

    def checkout(branch)
      run 'checkout', branch
    end

    # Executes `$ git pull`
    def pull
      run 'pull'
    end

    private

    def execute(command)
      `#{command}`.chomp
    end

    def run(*subcommands)
      command = "git #{subcommands.join(' ')}"
      execute(command)
    end

    def git_status_short
      run 'status', '--short'
    end
  end
end
