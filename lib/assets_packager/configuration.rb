# -*- encoding: utf-8 -*-
require 'yaml'

module AssetsPackager
  module Configuration
    extend self

    def write!
      javascripts = file_list("#{javascripts_path}/*.js",  true)
      stylesheets = file_list("#{stylesheets_path}/*.css", true)
      configuration = { 'js' => javascripts.reverse, 'css' => stylesheets }
      ::File.open(file_path, "w+") { |file| file.write(configuration.to_yaml) }
    end

    def file
      @@file ||= YAML.load_file(file_path).to_hash
    end

    def root_path=(path)
      @@root_path = path
    end

    def root_path
      @@root_path ||= ::File.expand_path(Dir.pwd)
    end

    def file_path=(path)
      @@file_path = path
    end

    def file_path
      @@file_path ||= current_dir_for('assets.yml')
    end

    def javascripts_path=(path)
      @@javascripts_path = path
    end

    def javascripts_path
      @@javascripts_path ||= current_dir_for('javascripts')
    end

    def stylesheets_path=(path)
      @@stylesheets_path = path
    end

    def stylesheets_path
      @@stylesheets_path ||= current_dir_for('stylesheets')
    end

    protected
      def file_list(path, trail_extension = false)
        Dir[path].map do |file|
          file = file.split('/').last
          file.split('.').first if trail_extension
        end
      end

      def current_dir_for(path)
        ::File.join(root_path, path)
      end
  end
end