
module ArticleManager
  class Controller
  	def initialize(output)
  		@output = output
  	end

  	def import(article_record)
  		imported_articles = import_articles(article_record)
  		@output.puts(format_response(imported_articles))
  	end

  	private

  	def format_response(articles)
  		response = articles.length > 0 ? "Added Articles:\n" : "No Articles Added: Empty Article Record."
  		response += articles.collect { |article| "\t#{article.title}\n" }.join
  	end

  	def import_articles(article_record)
  		record_rows = article_record.split("\n")
  		record_rows.select{ |x| is_article_row?(x) }.collect.with_index do | article_row, i |
  			create_article(article_row, i)
  		end
  	end

  	def create_article(article_row, index)
  		begin 
        Article.new(article_row.split(","))
  		rescue Exception => e
  			recover_from_article_creation_exception(e.message, index)
  		end
  	end

  	def recover_from_article_creation_exception(exception, index)
  		ExceptionArticle.new(exception, index + 1)
  	end

  	def is_article_row?(record_row)
  		!is_header_row?(record_row)
  	end

  	def is_header_row?(record_row)
  		record_row[0..4] == "Date,"
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