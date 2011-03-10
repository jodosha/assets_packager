# -*- encoding: utf-8 -*-

module AssetsPackager
  module Compressors
    class Stylesheet < Base
      def self.file
        AssetsPackager::Mergers::Stylesheet.file
      end

      private
        def self._compress_and_load!
          _compress_css(File.readlines(file).join)
        end

        # Thanks to Scott Becker
        def self._compress_css(content) #:nodoc:
          content.gsub!(/\s+/, " ")           # collapse space
          content.gsub!(/\/\*(.*?)\*\/ /, "") # remove comments - caution, might want to remove this if using css hacks
          content.gsub!(/\} /, "}\n")         # add line breaks
          content.gsub!(/\n$/, "")            # remove last break
          content.gsub!(/ \{ /, " {")         # trim inside brackets
          content.gsub!(/; \}/, "}")          # trim inside brackets
          content
        end
    end
  end
end