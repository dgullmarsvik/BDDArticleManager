require 'uri'
require 'date'

module ArticleManager
	class Article
  	attr_accessor :id, :title, :url, :date, :categories, :description
  		
  	def initialize(article_array)
  		raise "Empty Row" if article_array[0] == "\n"
  		raise "Too Few Values" if article_array.length < 5
  		raise "Missing Title" if article_array[1].to_s == ""
  		@id = -1
  		@date = Date.parse(article_array[0].strip)
  		@title = article_array[1].strip
  		@url = URI(article_array[2].strip)
  		@categories = article_array[3].strip
  		@description = article_array[4].strip
  	end

    def to_s
      "'#{@title}' - url: '#{@url}'\n\tDescription: #{@description}\n\tCategories: #{@categories}\n\tDate: #{@date.to_s}"
    end
  end
end