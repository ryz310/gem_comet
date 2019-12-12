# frozen_string_literal: true

module GemComet
  # Creates pull requests for gem release and that preparation
  class Release < ServiceAbstract
    def initialize(version:)
      verify_version_number(version)

      @version = version
      @config = Config.call
    end

    private

    attr_reader :version, :config

    def call
      VerifyGitCondition.call
      CreateUpdatePR.call(update_pr_args)
      CreateReleasePR.call(release_pr_args)
      OpenGithubPullsPage.call
    end

    def update_pr_args
      {
        version: version,
        base_branch: config.release.base_branch
      }
    end

    def release_pr_args
      {
        version: version,
        base_branch: config.release.base_branch,
        release_branch: config.release.release_branch
      }
    end

    def verify_version_number(version)
      return if version.match?(/\A\d+\.\d+\.\d+(\.(pre|beta|rc)\d*)?\z/)

      raise 'Verion number must be like a "1.2.3".'
    end
  end
end
