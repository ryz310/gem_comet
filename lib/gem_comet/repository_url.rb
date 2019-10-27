# frozen_string_literal: true

module GemComet
  # Gets the repository URL on the GitHub
  class RepositoryUrl < ServiceAbstract
    def initialize; end

    private

    # Returns the git origin URL via git command.
    #
    # @return [String] The origin URL
    def call
      if git_remote_command =~ /git@github.com:(.+).git/
        "https://github.com/#{Regexp.last_match(1)}"
      else
        git_remote_command.sub('.git', '').chomp
      end
    end

    def git_remote_command
      @git_remote_command ||= `git remote get-url --push origin`
    end
  end
end
