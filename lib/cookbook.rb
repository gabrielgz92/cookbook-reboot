require 'csv'

class Cookbook
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @recipes = []
    load_csv
  end

  def all # lists all recipes
    @recipes
  end

  def add_recipe(recipe) #receives an instance of recipe
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_recipe(index)
    @recipes[index].mark_as_done!
  end

  private

  def load_csv
    CSV.foreach(@csv_filepath) do |row|
      @recipes << Recipe.new({
        name: row[0],
        description: row[1],
        prep_time: row[2],
        difficulty: row[3]
      })
    end
  end

  def save_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << recipe.to_csv_row
      end
    end
  end
end
