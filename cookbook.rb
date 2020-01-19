require 'csv'
require_relative 'recipe'
require 'pry-byebug'

class Cookbook
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @recipes = []
    CSV.foreach(@csv_filepath) do |row|
      attributes = { title: row[0].to_s,
                     description: row[1].to_s,
                     author: row[2].to_s,
                     done: row[3].to_s == "Done" }
      @recipes << Recipe.new(attributes)
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def update_recipe_status_at(recipe_index)
    @recipes[recipe_index].update_status! unless recipe_index > @recipes.count
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  private

  def update_csv
    CSV.open(@csv_filepath, 'w') do |csv|
      @recipes.each do |recipe|
        done_serialized = (recipe.done? ? "Done" : "Waiting")
        csv << [recipe.title, recipe.description, recipe.author, done_serialized]
      end
    end
  end
end
