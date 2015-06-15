require "slimdown/version"
require "slimdown/exception"
require "slimdown/page_parser"
require "slimdown/folder"
require "slimdown/page"
require "slimdown/config"

# The main Slimdown namespace.
module Slimdown

  # Sets and retrieves global configuration.
  #
  # If called with a block, the config object will be passed to the block and
  # allow settings to be modified. This could be done in a Rails initializer:
  #
  #    Slimdown.config do |config|
  #      config.location = Rails.root.join 'pages'
  #    end
  #
  # The settings object is always returned.
  #
  # @param [Proc] block to call with config object.
  # @return [Slimdown::Config] object with configuration params.
  def self.config(&block)
    @config ||= Slimdown::Config.new

    # Allow configuration via a block.
    block.call(@config) if block

    @config
  end
end
