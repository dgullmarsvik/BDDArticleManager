module ArticleManager
  class Controller
  	def initialize(output, article_importer)
  		@output = output
      @article_importer = article_importer
  	end

  	def import(article_record)
  		imported_articles = @article_importer.import(article_record)
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