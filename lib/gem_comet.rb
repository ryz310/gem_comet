# frozen_string_literal: true

require 'thor'
require 'type_struct'
require 'type_struct/ext'
require 'pr_comet'
require 'yaml'
require 'gem_comet/version'
require 'gem_comet/service_abstract'
require 'gem_comet/config'
require 'gem_comet/version_editor'
require 'gem_comet/changelog'
require 'gem_comet/changelog/editor'
require 'gem_comet/changelog/generator'
require 'gem_comet/release'
require 'gem_comet/release/update_pr'
require 'gem_comet/release/release_pr'
require 'gem_comet/cli'

module GemComet
  LEGEND = 'Generated by [gem_comet](https://github.com/ryz310/gem_comet)'
end
