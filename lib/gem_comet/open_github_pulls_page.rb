# frozen_string_literal: true

module GemComet
  # Creates pull requests for gem release and that preparation
  class OpenGithubPullsPage < ServiceAbstract
    attr_reader :origin_url

    def initialize
      @origin_url = RepositoryUrl.call
    end

    private

    def call
      `open #{origin_url}/pulls`
    end
  end
end
