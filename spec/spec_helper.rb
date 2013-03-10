require 'articlemanager'

module ArticleManager
	class ArticleManagerHelper
		def initialize
			@articles = {testArticle1: "2013-01-01,Article Management 101,http://www.example.org/1/,Tutorial,For Beginners.",
									testArticle2: "2013-01-02,Advanced Article Management,http://www.example.org/2/,Tutorial,For Experts.",
									testArticleWithSpaces: " 2013-01-03 , Subtle Article Management , http://www.example.org/3/ , Guide , For Experts. ",
									testArticleWithTooFewFields: "Bad Practices for Article Management, http://www.example.org/4/, For Everyone."}
			@titles = {testArticle1: "Article Management 101",
									testArticle2: "Advanced Article Management",
									testArticleWithSpaces: "Subtle Article Management",
									testArticleWithTooFewFields: "Error, Row 1: An Article Record row needs 5 values.",
									testArticleAlreadyPresent: "Error, Row 0: Article with identical URL already exists."}
			@empty_article_record = "Date,Title,URL,Categories,Description"
			@response_header = "\nAdded Articles:"
			@empty_response = "\nNo Articles in Article Record."
		end

		def get_article_record(articles=[])
			article_record = articles.empty? ? @empty_article_record : @empty_article_record
			articles.each do |article|
				article_record << "\n#{@articles[article]}"
			end
			article_record
		end

		def get_article_title(article)
			@titles[article]
		end

		def get_article_record_with_empty_row(articles=[])
			article_record = get_article_record(articles)
			article_record.split("\n").insert(1,"\n").join
		end

		def get_article_response(articles=[])
			response = articles.empty? ? @empty_response : "#{@response_header}"
			articles.each do |article|
				response << "\n\t#{@titles[article]}"
			end
			response
		end
	end
end