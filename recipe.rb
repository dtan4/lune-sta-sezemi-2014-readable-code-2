#!/usr/bin/env ruby

require 'optparse'

user_id = nil
recipe_id = nil

OptionParser.new do |opts|
  opts.on("--user_id VAL" "user id") { |val| user_id = val.to_i }
  opts.on("--recipe_id VAL" "user id") { |val| recipe_id = val.to_i }
end.parse!

class RecipeData
  attr_reader :users, :recipes

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

  def recipes_by_user_id(user_id)
    @recipes.select { |recipe| recipe['user_id'] == user_id }
  end

  def recipe_by_id(recipe_id)
    @recipes.select { |recipe| recipe['id'] == recipe_id }.first
  end

  def user_by_id(user_id)
    @users.select { |user| user['id'] == user_id }.first
  end

  def show_recipes_by_user_id(user_id, recipe_id)
    user = user_by_id(user_id)
    puts "ユーザー名: #{user['id']}: #{user['name']}"
    recipes_by_user_id(user['id']).each do |recipe|
      if recipe_id.nil? || (recipe['id'] == recipe_id)
        puts "#{recipe['id']} #{recipe['name']} #{recipe['url']}"
      end
    end
    puts ""
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

id_num_opt = ARGV.size.odd? ? ARGV.last.to_i : nil

if user_id
  recipes.show_recipes_by_user_id(user_id, recipe_id)
else
  recipes.users.each do |user|
    recipes.show_recipes_by_user_id(user['id'], recipe_id)
  end
end
