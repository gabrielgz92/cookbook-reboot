class Recipe
  attr_reader :name, :description, :difficulty, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time] || "--"
    @difficulty = attributes[:difficulty] || "--"
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

  # getter
  # def name
  #   @name
  # end

  # # setter
  # def name=(name)
  #   @name = name
  # end

  def to_csv_row
    # user the readers / getters
    [name, description, difficulty, prep_time]
  end

  def to_s
    # status = done? ? 'X' : ' '
    "Name: #{name} "\
    "| Description: #{description} "\
    "| Prep time: #{prep_time} "\
    "| Difficulty; #{difficulty} "\
    "| Completed: [#{done? ? 'X' : ' '}]"
  end
end
