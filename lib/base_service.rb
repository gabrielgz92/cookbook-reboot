class BaseService
  # BaseService.call(there may be arguments)

  # ScrapeRecipeService.call(ingredient)

  def self.call(*args)
    # I have a class
    # .new => initialize => instance
    new(*args).call
  end
end
