module Slimdown
  class Page

    PAGES_PATH_NAME = 'pages'

    attr_reader :title
    attr_reader :template

    def initialize(absolute_path)
      # Open the markdown file.
      @absolute_path = absolute_path

      @parsed_page = Slimdown::PageParser.new @absolute_path

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

    def siblings
      # List other markdown files in the same folder.

      # Sibling folder.
      folder = File.dirname @absolute_path

      Slimdown::Folder.new(folder).pages
    end

    def children
      # Check to see whether dir exists.
      folder = @absolute_path
      folder.slice! '.md'

      Slimdown::Folder.new(folder).pages
    end

    def path
      loc = Slimdown.config.location
      relative = @absolute_path
      relative.slice! "#{loc}/#{PAGES_PATH_NAME}/"
      relative.slice! '.md'

      relative
    end

  private

    def load_headers
      headers = @parsed_page.headers
      @title = headers['title']
      @template = headers['template']
    end
  end
end
