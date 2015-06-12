module Slimdown
  class Folder
    def initialize(absolute_path)
      @absolute_path = absolute_path
    end

    def markdown_files
      return [] unless Dir.exists? @absolute_path

      dir = Dir.new @absolute_path
      files = dir.entries.grep(/\.md\z/i)
    end

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
