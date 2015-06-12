module Slimdown
  class Config

    attr_accessor :location

    def initialize
      # Set defaults.
      @location = 'pages/'
    end
  end
end
