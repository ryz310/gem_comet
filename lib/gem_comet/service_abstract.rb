# frozen_string_literal: true

module GemComet
  # The abstract class for service classes
  class ServiceAbstract
    private_class_method :new

    def self.call(**args)
      new(**args).send(:call)
    end

    def initialize(_args)
      raise "Please implement #{self.class}##{__method__}"
    end

    private

    def call
      raise "Please implement #{self.class}##{__method__}"
    end
  end
end
