require 'assets_packager'

unless Rake::Task.task_defined?('environment')
  task :environment do # Rails environment placeholder
  end
end

namespace :assets do
  desc "Package all the assets"
  task :package => 'package:all'

  desc "Clear all the assets"
  task :clear => 'clear:all'

  desc "Install configuration files"
  task :install do
    if ::Rails && ::Rails.root
      ::File.open(::Rails.root.join('config', 'initializers', 'assets.rb'), 'w+') do |file|
        file.write %(AssetsPackager.configure do |config|
  config.root_path = ::Rails.public_path
  config.file_path = ::Rails.root.join('config', 'assets.yml')
end)
      end

      puts "Please run `assets:config` now."
    end
  end

  desc "Write the configuration file"
  task :config => :environment do
    AssetsPackager::Configuration.write!
  end

  namespace :package do
    desc "Package all the assets"
    task :all => [ 'clear:all', :js, :css ]

    desc "Package all the javascripts"
    task :js => [ 'merge:js', 'compress:js' ]

    desc "Package all the stylesheets"
    task :css => [ 'merge:css', 'compress:css' ]
  end

  namespace :merge do
    desc "Merge all the assets"
    task :all => [ :js, :css ]

    desc "Merge all the javascripts"
    task :js => :environment do
      AssetsPackager::Mergers::Javascript.merge!
    end

    desc "Merge all the stylesheets"
    task :css => :environment do
      AssetsPackager::Mergers::Stylesheet.merge!
    end
  end

  namespace :compress do
    desc "Compress all the assets"
    task :all => [ :js, :css ]

    desc "Compress all the javascripts"
    task :js => :environment do
      AssetsPackager::Compressors::Javascript.compress!
    end

    desc "Compress all the stylesheets"
    task :css => :environment do
      AssetsPackager::Compressors::Stylesheet.compress!
    end
  end

  namespace :clear do
    desc "Clear all the assets"
    task :all => [ :js, :css ]

    desc "Clear packaged javascript"
    task :js => :environment do
      AssetsPackager::Cleaner.clear_javascripts!
    end

    desc "Clear packaged stylesheet"
    task :css => :environment do
      AssetsPackager::Cleaner.clear_stylesheets!
    end
  end
end