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
          content.gsub!(/\s+/, " ")                                                           # collapse space
          content.gsub!(/\/\*(.*?)\*\/ /, "")                                                 # remove comments - caution, might want to remove this if using css hacks
          content.gsub!(/\} /, "}\n")                                                         # add line breaks
          content.gsub!(/\n$/, "")                                                            # remove last break
          content.gsub!(/ \{ /, " {")                                                         # trim inside brackets
          content.gsub!(/; \}/, "}")                                                          # trim inside brackets
          content.gsub!(/url\((.*)\.(gif|jpg|png)\)/) { "url(#{_timestamp("#{$1}.#{$2}")})" } # append a timestamp like: /images/logo.png?1286374077
          content
        end

        def self._timestamp(path) #:nodoc:
          if ::File.exist?( expanded_path = ::File.expand_path(::File.join(AssetsPackager::Configuration.root_path, path)) )
            path << "?#{::File.mtime(expanded_path).to_i}"
          end

          path
        end
    end
  end
end