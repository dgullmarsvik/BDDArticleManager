module ArticleManager
	class ExceptionArticle
  	attr_accessor :title
  		
  	def initialize(error, index)
  		case error
  		when "Too Few Values"
  			@title = "Error, Row #{index}: An Article Record row needs 5 values."
  		when "Empty Row"
  			@title = "Skipping Row #{index}: Empty Row."
  		when "bad URI(is not URI?): invalid url"
  			@title = "Error, Row #{index}: Not a valid URL."
  		when "invalid date"
  			@title = "Error, Row #{index}: Not a valid Date."
  		when "Missing Title"
  			@title = "Error, Row #{index}: Missing title for article."
  		else
  			@title = "Error, Row #{index}: #{error}"
  		end
  	end
  end
end