require 'fileutils'
require 'active_support/core_ext/string'
require 'yaml'

@file = ARGV[0]
data = if @file == "-"
  $stdin.read
else
  File.read(@file)
end

@dir = ARGV[1]
raise unless File.directory?(@dir)

YAML.load_stream(data).each do |doc|
  next if doc.nil?
  kind = doc['kind'].downcase.pluralize
  kind_dir = File.join(@dir, kind)
  FileUtils.mkdir_p(kind_dir)
  name = doc['metadata']['name'] + '.yaml'
  filename = File.join(kind_dir, name)
  puts "Writing #{filename} ..."
  File.open(File.join(kind_dir, name), 'w') do |file|
    file.write(doc.to_yaml)
  end
end
