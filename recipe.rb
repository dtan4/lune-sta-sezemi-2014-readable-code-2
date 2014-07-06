#!/usr/bin/ruby

file_name = ARGV[0]
recipe_data_array = File.open(file_name).read.split("\n")

id_num = 0
recipe_data_array.each do |recipe|
  id_num += 1
  puts "#{id_num}: #{recipe}"
end
