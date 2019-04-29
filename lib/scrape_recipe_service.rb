require 'nokogiri'
require 'open-uri'
require_relative 'base_service'

class ScrapeRecipeService < BaseService
  BASE_URL = "http://www.letscookfrench.com/recipes/"

  def initialize(ingredient)
    @url = BASE_URL + "find-recipe.aspx?aqt=#{ingredient}"
  end

  def call
    html_file = open(@url).read # String
    html_doc = Nokogiri::HTML(html_file)
    # map => [] transformed with the result value of the block
    html_doc.search(".m_item.recette_classique").take(5).map do |element|
      Recipe.new({
        name: get_name(element),
        description: get_description(element),
        difficulty: get_difficulty(element),
        prep_time: get_prep_time(element)
      })
    end
  end

  private

  def get_name(element)
    element.search(".m_titre_resultat").text.strip
  end

  def get_description(element)
    element.search(".m_texte_resultat").text.strip
  end

  def get_prep_time(element)
    element.search(".m_prep_time").first.parent.text.strip
  end

  def get_difficulty(element)
    element.search(".m_detail_recette").text.strip.split("-").map(&:strip)[2]
  end
end







