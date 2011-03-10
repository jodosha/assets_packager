$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), '/../lib')))
ARGV << "-b"
require 'rubygems'
require 'bundler'
Bundler.setup
require 'assets_packager'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include AssetsPackager::Matchers

  config.before :all do
    root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
    root_path   = File.join(root, 'spec', 'fixtures', 'public')
    config_path = File.join(root, 'spec', 'fixtures', 'config', 'assets.yml')

    AssetsPackager.configure do |config|
      config.root_path = root_path
      config.file_path = config_path
    end

    AssetsPackager::Cleaner.clear!
  end

  config.after :each do
    AssetsPackager::Cleaner.clear!
  end
end
