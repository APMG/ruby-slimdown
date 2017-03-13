module Slimdown
  # The model representing a page
  class Page

    # The title from the document headers
    attr_reader :title
    # The template from the document headers
    attr_reader :template
    # All the document headers
    attr_reader :headers

    # Get new page object
    #
    # @param [String] absolute_path The absolute path to this document,
    #   including extension.
    def initialize(absolute_path)
      # Open the markdown file.
      @absolute_path = absolute_path

      @parsed_page = Slimdown::PageParser.new @absolute_path

      load_headers
    end

    # Get page object by relative path.
    #
    # Example:
    #    Slimdown::Page.find('about/contact')
    #
    # @param [String] path relative path to page. Doesn't include extension.
    # @return [Slimdown::Page] the page corresponding to this path.
    def self.find(path)
      # Finds the relative page.
      config = Slimdown.config
      loc = config.location

      self.new("#{loc}/#{path}.md")
    end

    # Get the parsed body
    #
    # @return [Kramdown::Document] the parsed Markdown body.
    def body
      @parsed_page.body
    end

    # The sibling pages to this document.
    #
    # @return [Array<Slimdown::Page>] a list of sibling pages.
    def siblings
      # List other markdown files in the same folder.

      # Sibling folder.
      folder = File.dirname @absolute_path

      Slimdown::Folder.new(folder).pages
    end

    # The children of this document.
    #
    # @return [Array<Slimdown::Page>] a list of child pages.
    def children
      # Check to see whether dir exists.
      folder = @absolute_path
      folder.slice! '.md'

      Slimdown::Folder.new(folder).pages
    end

    # The relative path for this document.
    #
    # @return [String] the relative path, e.g. 'about/contact'
    def path
      loc = Slimdown.config.location
      relative = @absolute_path
      relative.slice! "#{loc}/"
      relative.slice! '.md'

      relative
    end

  private

    def load_headers
      @headers = @parsed_page.headers
      @title = @headers['title']
      @template = @headers['template']
    end
  end
end
