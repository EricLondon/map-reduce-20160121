#!/usr/bin/env jruby

# require gems
require 'optparse'
require 'pry'

root_path_relative = File.join(File.dirname(__FILE__), '..')
root_path = File.expand_path root_path_relative

$LOAD_PATH << root_path
$LOAD_PATH << File.join(root_path, 'bin')
$LOAD_PATH << File.join(root_path, 'lib')

# require custom classes
require 'map_reducer'

options = { action: nil }
OptionParser.new do |opts|
  opts.on('--map', 'Map') do |_v|
    options[:action] = :map
  end

  opts.on('--reduce', 'Reduce') do |_v|
    options[:action] = :reduce
  end
end.parse!

map_reducer = MapReducer.new(options).execute
