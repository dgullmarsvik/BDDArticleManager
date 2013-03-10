require 'uri'

module ArticleManager
	class ArticleRepository
		def initialize(article_array = [])
			raise "Error: ArticleRepository cannot be initialized with a non-Article-array" if article_array.length > 0 && !article_array[0].instance_of?(Article)
			@internal_storage = article_array
		end

		def add_array(article_array)
			article_array.collect.with_index { | article, i | add(article, i) }
		end

		def add(article, original_index = 1)
			if !is_article_valid_for_insertion?(article)
				return recover_from_invalid_article(article, original_index)
			end
			@internal_storage.push(article).first
		end

		def exists?(article)
			!find_by_url(article.url.to_s).nil?
		end

		def find_by_url(url)
			@internal_storage.select{ | x | x.url.to_s == URI(url).to_s }.first
		end

		def find_all
			return @internal_storage
		end

		private 
		def is_article_valid_for_insertion?(article)
			article.instance_of?(Article) && !exists?(article)
		end

		def recover_from_invalid_article(article, original_index)
			if article.instance_of?(ExceptionArticle)
				return article
			elsif !article.instance_of?(Article)
				return ExceptionArticle.new("Not an Article", original_index)
			end
			ExceptionArticle.new("Duplicate Article", original_index)		
		end
	end
end