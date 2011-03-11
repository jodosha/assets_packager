# -*- encoding: utf-8 -*-

module AssetsPackager
  module Mergers
    class Base
      def self.merge!
        content = load_files!
        File.open(file, 'w+') { |f| f.write content }
      end

      def self.file
        @file ||= ::File.join(path, "all.#{type}")
      end

      def self.path
        raise "Not implemented"
      end

      def self.type
        raise "Not implemented"
      end

      protected
        def self.load_files!
          files = AssetsPackager::Configuration.file[type].map {|file| "#{path}/#{file}.#{type}" }
          lines = []
          files.each do |file|
            lines << File.readlines(file)
          end

          lines
        end
    end
  end
end