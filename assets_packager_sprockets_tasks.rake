# Copyright 2010 Luca Guidi - www.lucaguidi.com - Released under MIT License
# http://github.com/jodosha/assets_packager

RAILS_ROOT = File.expand_path(Dir.pwd) unless defined? RAILS_ROOT
CONFIGURATION = "#{RAILS_ROOT}/config/assets.yml"
JS_PATH = RAILS_ROOT + '/public'
CSS_PATH = RAILS_ROOT + '/public/stylesheets'
STYLESHEETS = CSS_PATH + '/*.css'
JSMIN = "#{RAILS_ROOT}/script/jsmin"

namespace :assets do
  desc "Package all the assets"
  task :package => 'package:all'
  
  desc "Clear all the assets"
  task :clear => 'clear:all'
  
  desc "Write the configuration file"
  task :config do
    require 'yaml'
    stylesheets = file_list STYLESHEETS, true
    configuration = { 'css' => stylesheets }
    File.open(CONFIGURATION, "w+") { |file| file.write(configuration.to_yaml) }
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
    task :js => 'sprockets:install_script'
    
    desc "Merge all the stylesheets"
    task :css do
      merge CSS_PATH, :css
    end
  end
  
  namespace :compress do
    desc "Compress all the assets"
    task :all => [ :js, :css ]
    
    desc "Compress all the javascripts"
    task :js do
      `#{JSMIN} <#{sprockets_path} >#{JS_PATH}/sprockets_compressed.js \n`
      `mv #{JS_PATH}/sprockets_compressed.js #{sprockets_path}`
      # Remove the blank line on the top of the file
      lines = File.readlines(sprockets_path)[1..-1]
      File.open(sprockets_path, 'w+') { |file| file.write lines }
    end
    
    desc "Compress all the stylesheets"
    task :css do
      path = "#{CSS_PATH}/all.css"
      lines = compress_css(File.readlines(path).join)
      File.open(path, 'w+') { |file| file.write lines }
    end
  end
  
  namespace :clear do
    desc "Clear all the assets"
    task :all => [ :js, :css ]
    
    desc "Clear all the packaged javascripts"
    task :js do
      FileUtils.rm sprockets_path rescue nil
    end
    
    desc "Clear all the packaged stylesheets"
    task :css do
      FileUtils.rm(CSS_PATH + '/all.css') rescue nil
    end    
  end
end

def sprockets_path
  File.join(JS_PATH, 'sprockets.js')
end

def file_list(path, trail_extension = false)
  Dir[path].map do |file|
    file = file.split('/').last
    file.split('.').first if trail_extension
  end
end

def merge(path, type)
  files = YAML.load_file(CONFIGURATION).to_hash[type.to_s].map {|file| "#{path}/#{file}.#{type}"}
  lines = files.inject([]) do |result, file|
    result << File.readlines(file)
    result
  end
  File.open("#{path}/all.#{type}", "w+") { |file| file.write lines }
end

def compress_css(source)
  source.gsub!(/\s+/, " ")           # collapse space
  source.gsub!(/\/\*(.*?)\*\/ /, "") # remove comments - caution, might want to remove this if using css hacks
  source.gsub!(/\} /, "}\n")         # add line breaks
  source.gsub!(/\n$/, "")            # remove last break
  source.gsub!(/ \{ /, " {")         # trim inside brackets
  source.gsub!(/; \}/, "}")          # trim inside brackets
  source
end
