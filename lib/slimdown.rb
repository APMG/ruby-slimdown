require "slimdown/version"
require "slimdown/exception"
require "slimdown/page_parser"
require "slimdown/folder"
require "slimdown/page"
require "slimdown/config"

module Slimdown
  def self.config(&block)
    @config ||= Slimdown::Config.new

    # Allow configuration via a block.
    block.call(@config) if block

    @config
  end
end
