require 'yaml'
require 'kramdown'

module Slimdown
  # Internal class to manage parsing the markdown document.
  class PageParser
    # @param [String] path The absolute path to the markdown document.
    def initialize(path)
      @path = path

      parse_file
    end

    # A hash of the headers in the document
    #
    # Example:
    #     {
    #       "title" => "Test title",
    #       "template" => "test_template",
    #     }
    #
    # @return [Hash] document headers
    def headers
      YAML.load @header_text
    end

    # The parsed markdown document body.
    #
    # @return [Kramdown::Document] a markdown document object.
    def body
      Kramdown::Document.new(@body_text)
    end

  private

    def parse_file
      # Simple state machine.
      part = nil

      @header_text = ''
      @body_text = ''

      File.open(@path, 'r') do |f|
        f.each_line do |line|
          if line.strip == '---' && !part
            part = :header
          elsif line.strip == '---' && part == :header
            part = :body
          elsif part == :header
            @header_text += "#{line}\n"
          elsif part == :body
            @body_text += "#{line}\n"
          end
        end
      end

    rescue Errno::ENOENT
      raise Slimdown::Exception, 'Page not found'
    end

  end
end
