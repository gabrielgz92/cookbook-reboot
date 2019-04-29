require_relative 'cookbook'
require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook # this is a Cookbook instance
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

  def create
    # ask user for name
    name = @view.ask_for(:name)
    # ask user for description
    description = @view.ask_for(:description)
    # create a Recipe instance
    recipe = Recipe.new(name, description)
    # pass it to the cookbook (repo)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # self.list same as:
    recipes = list
    range = 0...recipes.length
    # ask for a index
    index = @view.ask_for_index(:remove, range)
    # pass index to cookbook
    @cookbook.remove_recipe(index)
  end

  def import
   # Ask user for ingredient to import
   ingredient = @view.ask_for(:ingredient)
   # Visit LetsCookFrench results for that ingredient
   # recipes = ScrapeRecipeService.new(ingredient).call
   recipes = ScrapeRecipeService.call(ingredient)
   range = 0...recipes.length
   # Display search results
   @view.display_recipes(recipes)
   # Ask user to pick a recipe from 5 results
   index = @view.ask_for_index(:import, range)
   # Add chosen recipe to the cookbook (repository)
   recipe = recipes[index]
   @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # list the recipes
    recipes = list
    range = 0...recipes.length
    # ask for the index to mark
    index = @view.ask_for_index("mark as done", range)
    # mark recipe
    @cookbook.mark_recipe(index)
  end
end






