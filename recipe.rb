#!/usr/bin/ruby

file_name = ARGV[0]
recipe_data = File.open(file_name).read
puts recipe_data

