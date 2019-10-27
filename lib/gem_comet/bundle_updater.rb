# frozen_string_literal: true

module GemComet
  # Executes `$ bundle update` command
  class BundleUpdater < ServiceAbstract
    def initialize; end

    private

    def call
      `bundle update`
    end
  end
end
