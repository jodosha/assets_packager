# -*- encoding: utf-8 -*-

module AssetsPackager
  autoload :Configuration, 'assets_packager/configuration'
  autoload :Cleaner,       'assets_packager/cleaner'
  autoload :Mergers,       'assets_packager/mergers'
  autoload :Compressors,   'assets_packager/compressors'

  # Configure <tt>AssetsPackager</tt>.
  #
  # Example:
  #   AssetsPackager.configure do |config|
  #     config.root_path = '/path/to/public/folder'
  #   end
  #
  # Options:
  # * <tt>root_path</tt>: Specify the directory where your javascript and stylesheet
  # directories are. i.e. <tt>Rails.public_path</tt>. Default: <tt>Dir.pwd</tt>.
  # * <tt>file_path</tt>: Specify the path of the <tt>YAML</tt> configuration file.
  # Default: <tt>root_path + '/assets.yml'</tt>.
  # * <tt>javascripts_path</tt>: Specify where your javascripts are placed.
  # Default: <tt>root_path + '/javascripts'</tt>
  # * <tt>stylesheets_path</tt>: Specify where your stylesheets are placed.
  # Default: <tt>root_path + '/stylesheets'</tt>
  #
  # Notice: If you are in a <tt>Rails</tt> context, everything is already configured.
  def self.configure
    yield AssetsPackager::Configuration
  end
end

if defined?(Rails)
  require 'assets_packager/rails'
end
