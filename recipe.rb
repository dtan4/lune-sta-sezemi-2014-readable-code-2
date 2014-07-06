#!/usr/bin/ruby

user = ARGV[0]
file_name = ARGV[1]
id_num_opt = ARGV.size.odd? ? nil : ARGV[ARGV.size -1].to_i

class RecipeData

  def initialize
    @users = {}
    @recipes = {}
    
    @last_user_id_num = 
    @last_recipe_id_num = 0
  end
  
  def add_user(user_name)
    @last_user_id_num += 1
    @users[@last_user_id_num] = {
      'name' => user_name
    }
  end

  def add_recipe_file(file_name)
    File.open(file_name).read.split("\n").each do |line|
      @last_recipe_id_num += 1
      name, url = line.split(" ")
      @recipes[@last_recipe_id_num] = {
        'name'    => name,
        'url'     => url,
        'user_id' => @last_user_id_num
      }
    end
  end
  
  def to_a(id_num = nil)
    
  end

  def get_recipe(id_num)
    name = @recipes[id_num]['name']
    url = @recipes[id_num]['url']
    user_id = @recipes[id_num]['user_id']
    return ["#{id_num}: #{name} #{url}"]
  end

  def get_all_recipe
    result = []
    @recipes.keys.each do |id_num|
      result << get_recipe(id_num)
    end
    return result.flatten
  end

end

recipes = RecipeData.new

(ARGV.size/2).times do |i|
  i *= 2
  user_name = ARGV[i]
  file_name = ARGV[i+1]
  recipes.add_user(user_name)
  recipes.add_recipe_file(file_name)
end

puts recipes.to_a(id_num_opt)

