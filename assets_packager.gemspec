# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "assets_packager/version"

Gem::Specification.new do |s|
  s.name        = "assets_packager"
  s.version     = AssetsPackager::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Luca Guidi"]
  s.email       = ["guidi.luca@gmail.com"]
  s.homepage    = "http://github.com/jodosha/assets_packager"
  s.summary     = %q{A packager for your assets}
  s.description = %q{Compress and merge your JavaScript and CSS files}

  s.rubyforge_project = "assets_packager"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.5.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.5.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.5.0"])
  end
end
