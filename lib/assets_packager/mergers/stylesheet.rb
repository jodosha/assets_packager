# -*- encoding: utf-8 -*-

module AssetsPackager
  module Mergers
    class Stylesheet < Base
      def self.path
        AssetsPackager::Configuration.stylesheets_path
      end

      def self.type
        'css'
      end
    end
  end
end