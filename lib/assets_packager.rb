# -*- encoding: utf-8 -*-

module AssetsPackager
  autoload :Configuration, 'assets_packager/configuration'
  autoload :Cleaner,       'assets_packager/cleaner'
  autoload :Mergers,       'assets_packager/mergers'
  autoload :Compressors,   'assets_packager/compressors'

  def self.configure
    yield AssetsPackager::Configuration
  end
end

if defined?(Rails)
  require 'assets_packager/rails'
end
