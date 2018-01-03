require 'fileutils'
require 'active_support/core_ext/string'
require 'yaml'

@file = ARGV[0]
raise unless File.file?(@file)

@dir = ARGV[1]
raise unless File.directory?(@dir)

YAML.load_stream(File.read(@file)).each do |doc|
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
