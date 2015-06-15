module Slimdown
  # Internal class for managing global configuration.
  #
  # Only used by singleton Slimdown module.
  class Config

    # Get the path to the markdown pages.
    attr_accessor :location

    def initialize
      # Set defaults.
      @location = 'pages/'
    end
  end
end
