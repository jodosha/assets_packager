# -*- encoding: utf-8 -*-

module AssetsPackager
  module Compressors
    class Base
      def self.compress!
        content = _compress_and_load!
        ::File.open(file, 'w+') { |file| file.write content }
      end

      def self.file
        raise "Not implemented"
      end

      private
        def self._compress_and_load!
          raise "Not implemented"
        end
    end
  end
end