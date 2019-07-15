# frozen_string_literal: true

module GemComet
  # The abstract class for service classes
  class ServiceAbstract
    def self.call(*args)
      new(*args).send(:call)
    end

    private

    def initialize(_args)
      raise "Please implement #{self.class}##{__method__}"
    end

    def call
      raise "Please implement #{self.class}##{__method__}"
    end
  end
end
