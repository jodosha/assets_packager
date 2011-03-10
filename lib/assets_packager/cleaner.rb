# -*- encoding: utf-8 -*-
require 'fileutils'

module AssetsPackager
  module Cleaner
    extend self

    def clear!
      clear_configuration!
      clear_javascripts!
      clear_stylesheets!
    end

    def clear_configuration!
      FileUtils.rm AssetsPackager::Configuration.file_path rescue nil
    end

    def clear_javascripts!
      FileUtils.rm AssetsPackager::Mergers::Javascript.file rescue nil
    end

    def clear_stylesheets!
      FileUtils.rm AssetsPackager::Mergers::Stylesheet.file rescue nil
    end
  end
end