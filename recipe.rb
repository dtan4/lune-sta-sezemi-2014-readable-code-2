#!/usr/bin/ruby

file_name = ARGV[0]
id_num_opt = ARGV[1]

class RecipeDatabase

  def initialize
    @recipes = Hash.new()
    @last_id_num = 0
  end

  def add_recipe_file(file_name)
    File.open(file_name).read.split("\n").each do |line|
      @last_id_num += 1
      @recipes[@last_id_num] = {
        'name' => line
      }
    end
  end

  def puts_recipe(id_num)
    name = @recipes[id_num]['name']
    puts "#{id_num}: #{name}"
  end

  def puts_all_recipe
    @recipes.keys.each do |id_num|
      puts_recipe(id_num)
    end
  end

end

recipes = RecipeDatabase.new
recipes.add_recipe_file(file_name)
id_num_opt.nil? ? recipes.puts_all_recipe : recipes.puts_recipe(id_num_opt.to_i)

