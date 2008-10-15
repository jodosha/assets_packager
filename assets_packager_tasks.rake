RAILS_ROOT = File.expand_path(Dir.pwd) unless defined? RAILS_ROOT
CONFIGURATION = "#{RAILS_ROOT}/config/assets.yml"
JS_PATH = RAILS_ROOT + '/public/javascripts'
CSS_PATH = RAILS_ROOT + '/public/stylesheets'
JAVASCRIPTS = JS_PATH + '/*.js'
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
    javascripts = file_list JAVASCRIPTS, true
    stylesheets = file_list STYLESHEETS, true
    configuration = {'js' => javascripts.reverse, 'css' => stylesheets}
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
    task :js do
      merge JS_PATH, :js
    end
    
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
      path = JS_PATH + '/all.js'
      `#{JSMIN} <#{path} >#{JS_PATH}/all_compressed.js \n`
      `mv #{JS_PATH}/all_compressed.js #{path}`
      # Remove the blank line on the top of the file
      lines = File.readlines(path)[1..-1]
      File.open(path, 'w+') { |file| file.write lines }
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
    
    desc "Package all the javascripts"
    task :js do
      FileUtils.rm(JS_PATH + '/all.js') if File.exist?(JS_PATH + '/all.js')
    end
    
    desc "Package all the stylesheets"
    task :css do
      FileUtils.rm(CSS_PATH + '/all.css') if File.exist?(CSS_PATH + '/all.css')
    end    
  end
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

# Thanks to Scott Becker
def compress_css(source)
  source.gsub!(/\s+/, " ")           # collapse space
  source.gsub!(/\/\*(.*?)\*\/ /, "") # remove comments - caution, might want to remove this if using css hacks
  source.gsub!(/\} /, "}\n")         # add line breaks
  source.gsub!(/\n$/, "")            # remove last break
  source.gsub!(/ \{ /, " {")         # trim inside brackets
  source.gsub!(/; \}/, "}")          # trim inside brackets
  source
end
