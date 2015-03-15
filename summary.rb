#!/opt/rubies/ruby-2.2.1/bin/ruby
require 'pathname'

dirs = %w(
fastladder
gitlabhq
lodge
redmine
rubygems.org
spree
whitehall
)

h = {}

path = Pathname.new File.dirname(__FILE__)

dirs.each do |dir|
  chunks = (path + dir + '.rubocop_todo.yml').read.split("\n\n")
  chunks.shift
  chunks.each do |chunk|
    chunk =~ /(^[A-Z][\s\S]+):\n/
    type = $1
    h[type] ||= {}
    h[type][dir] ||= {}

    chunk =~ /^# Offense count: (\d+)/
    h[type][dir][:count] = $1

    match = chunk =~ /^# Cop supports --auto-correct\./
    h[type][dir][:auto_correct] = !!match
  end
end

h = h.sort.to_h

puts '|' + dirs.join('|') + '|'
puts '|' + dirs.map{':---'}.join('|') + '|'
h.each do |k, v|
  print "|#{k}"
  dirs.each do |dir|
    print "|#{(v[dir] || {})[:count]}"
  end
  puts "|"
end

