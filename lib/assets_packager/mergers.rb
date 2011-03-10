# -*- encoding: utf-8 -*-

module AssetsPackager
  module Mergers
    autoload :Base,       'assets_packager/mergers/base'
    autoload :Javascript, 'assets_packager/mergers/javascript'
    autoload :Stylesheet, 'assets_packager/mergers/stylesheet'
  end
end