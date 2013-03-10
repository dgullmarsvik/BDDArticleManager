module ArticleManager
  class Controller
  	def initialize(output, article_parser, article_repository)
  		@output = output
      @article_parser = article_parser
      @article_repository = article_repository
  	end

  	def import(article_record)
  		parsed_articles = @article_parser.parse(article_record)
      imported_articles = @article_repository.add_array(parsed_articles)
      @output.puts(format_import_response(imported_articles))
  	end

    def list_all_articles
      @output.puts("No Articles in Article Repository.")
    end

  	private

  	def format_import_response(articles)
  		response = articles.length > 0 ? "Added Articles:\n" : "No Articles Added: Empty Article Record."
      response += articles.collect { |article| "\t#{article.title}\n" }.join
  	end
  end
end

#BookStore
#  ->import
#  list_articles
#  details
#   remove
#   update
#
#  add
#  export