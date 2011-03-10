require 'bundler'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rspec/core/rake_task'

task :default => :spec

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-fs --color --backtrace']
end