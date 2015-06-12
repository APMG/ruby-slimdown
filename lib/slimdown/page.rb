module Slimdown
  class Page

    PAGES_PATH_NAME = 'pages'

    attr_reader :title
    attr_reader :template

    def initialize(path)
      # Open the markdown file.
      @path = path

      @parsed_page = Slimdown::PageParser.new @path

      load_headers
    end

    def self.find(path)
      # Finds the relative page.
      config = Slimdown.config
      loc = config.location

      self.new("#{loc}/#{PAGES_PATH_NAME}/#{path}.md")
    end

    def body
      @parsed_page.body
    end

  private

    def load_headers
      headers = @parsed_page.headers
      @title = headers['title']
      @template = headers['template']
    end
  end
end
