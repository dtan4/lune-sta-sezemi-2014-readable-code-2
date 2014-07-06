#!/usr/bin/env ruby

require 'pry'

user = ARGV[0]
file_name = ARGV[1]
id_num_opt = ARGV.size.odd? ? ARGV.last.to_i : nil

class RecipeData
  attr_reader :users

  def initialize
    @users = []
    @recipes = []

    @last_user_id_num =
    @last_recipe_id_num = 0
  end

  def add_user(user_name)
    @last_user_id_num += 1
    @users << {
      'id' => @last_user_id_num,
      'name' => user_name
    }
  end

  def add_recipe_file(file_name)
    File.open(file_name).read.split("\n").each do |line|
      @last_recipe_id_num += 1
      name, url = line.split(" ")
      @recipes << {
        'id'      => @last_recipe_id_num,
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

  def recipes_by_user(user_id)
    @recipes.select { |recipe| recipe['user_id'] == user_id }
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

recipes.users.each do |user|
  puts "ユーザー名: #{user['name']}"
  recipes.recipes_by_user(user['id']).each do |recipe|
    if id_num_opt.nil? || (recipe['id'] == id_num_opt)
      puts "#{recipe['id']} #{recipe['name']} #{recipe['url']}"
    end
  end
  puts ""
end
