module ArticleManager
  class Controller
  	def initialize(output, article_parser)
  		@output = output
      @article_parser = article_parser
  	end

  	def import(article_record)
  		imported_articles = @article_parser.parse(article_record)
  		@output.puts(format_response(imported_articles))
  	end

  	private

  	def format_response(articles)
  		response = articles.length > 0 ? "Added Articles:\n" : "No Articles Added: Empty Article Record."
  		response += articles.collect { |article| "\t#{article.title}\n" }.join
  	end
  end
end

#BookStore
#  import
#  export
#  add
#  remove
#  update
#  details
#  list_articles