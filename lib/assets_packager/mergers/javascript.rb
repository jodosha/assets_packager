# -*- encoding: utf-8 -*-

module AssetsPackager
  module Mergers
    class Javascript < Base
      def self.path
        AssetsPackager::Configuration.javascripts_path
      end

      def self.type
        'js'
      end
    end
  end
end