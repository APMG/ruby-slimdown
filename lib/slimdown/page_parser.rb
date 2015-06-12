require 'yaml'
require 'kramdown'

module Slimdown
  class PageParser
    def initialize(path)
      @path = path

      parse_file
    end

    def headers
      YAML.load @header_text
    end

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
    end

  end
end
