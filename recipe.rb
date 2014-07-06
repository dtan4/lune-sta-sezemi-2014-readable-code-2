#!/usr/bin/env ruby

require 'pry'

user = ARGV[0]
file_name = ARGV[1]
id_num_opt = ARGV.size.odd? ? ARGV.last.to_i : nil

class RecipeData
  attr_reader :users

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

  def recipes_by_user(user_id)
    @recipes.values.select { |recipe| recipe['user_id'] == user_id }
  end

  def recipe_id_of(recipe_name)
    @recipes.each do |id, recipe|
      return id if recipe['name'] == recipe_name
    end

    -1
  end

  def user_id_of(user_name)
    @users.each do |id, user|
      return id if user['name'] == user_name
    end

    -1
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

recipes.users.each do |user_id, user|
  puts "ユーザー名: #{user['name']}"
  recipes.recipes_by_user(user_id).each do |recipe|
    if id_num_opt.nil? || (recipes.recipe_id_of(recipe['name']) == id_num_opt)
      puts "#{recipe['name']} #{recipe['url']}"
    end
  end
  puts ""
end
