module Slimdown
  # Internal class for retrieving information about a folder.
  class Folder
    def initialize(absolute_path)
      @absolute_path = absolute_path
    end

    # Returns a list of markdown files in the folder.
    #
    # @return [Array<String>] List of paths.
    def markdown_files
      return [] unless Dir.exists? @absolute_path

      dir = Dir.new @absolute_path
      files = dir.entries.grep(/\.md\z/i)
    end

    # Returns a list of page objects in the folder.
    #
    # @return [Array<Slimdown::Page>] List of pages.
    def pages
      pages = []

      markdown_files.each do |file|
        path = "#{@absolute_path}/#{file}"
        pages << Slimdown::Page.new(path)
      end

      pages
    end
  end
end
