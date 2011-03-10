# -*- encoding: utf-8 -*-

module AssetsPackager
  module Compressors
    autoload :Base,       'assets_packager/compressors/base'
    autoload :Javascript, 'assets_packager/compressors/javascript'
    autoload :Stylesheet, 'assets_packager/compressors/stylesheet'
  end
end