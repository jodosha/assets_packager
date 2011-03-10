# -*- encoding: utf-8 -*-

module AssetsPackager
  module Compressors
    class Javascript < Base
      def self.path
        AssetsPackager::Mergers::Javascript.path
      end

      def self.file
        AssetsPackager::Mergers::Javascript.file
      end

      private
        def self._compress_and_load!
          compressed = ::File.join(path, 'all_compressed.js')
          system "jsmin <#{file} > #{compressed}"
          system "mv #{compressed} #{file}"

          # Remove the blank line on the top of the file
          File.readlines(file)[1..-1]
        end
    end
  end
end