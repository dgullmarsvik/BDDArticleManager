require 'uri'
require 'date'

module ArticleManager
	class ArticleRepository
		def initialize(article_array = [])
			raise "Error: ArticleRepository cannot be initialized with a non-Article-array" if article_array.length > 0 && !article_array[0].is_a?(Article)
			@articles = article_array
		end

		def add_array(article_array)
			article_array.collect.with_index { | article, i | insert(article, i) }
		end

		def insert(article, id = 1)
			is_insert_bad?(article) ? salvage_bad_insert(article, id) : @articles.push(article).last
		end

		def delete(id)
			is_id_bad?(id) ? salvage_bad_id(id) : @articles.delete_at(id - 1)
		end

		def update_article_with_id(id, article)
			is_update_bad?(id, article) ? salvage_bad_update(id, article) : @articles[id-1] = article
		end

		def find_by_id(id)
			is_id_bad?(id) ? salvage_bad_id(id) : @articles[id - 1]
		end

		def find_by_url(url)
			@articles.select{ | x | x.url.to_s == URI(url).to_s }.first
		end

		def find_all
			return @articles
		end

		def exists?(article)
			!find_by_url(article.url.to_s).nil?
		end

		private 
		def is_id_bad?(id)
			!id.is_a?(Integer) || id <= 0 || id > @articles.length
		end

		def salvage_bad_id(id)
			if !id.is_a?(Integer) || id <= 0
				ExceptionArticle.new("ID Is Non-Positive-Integer", id)
			elsif id > @articles.length
				ExceptionArticle.new("Non-Existant Article", id)
			end
		end

		def is_update_bad?(id, article)
			is_id_bad?(id) || is_article_bad?(id, article)
		end

		def salvage_bad_update(id,article)
			if is_id_bad?(id)
				salvage_bad_id(id)
			elsif article.is_a?(ExceptionArticle)
				article
			elsif !article.is_a?(Article)
				ExceptionArticle.new("Not an Article", id)
			elsif is_date_bad?(article)
				ExceptionArticle.new("Not A Valid Date", id)
			elsif is_url_bad?(id, article)
				ExceptionArticle.new("Not A Valid URL", id)
			elsif article.title == ""
				ExceptionArticle.new("Missing Title", id)
			else
				ExceptionArticle.new("Unknown Error", id)
			end
		end

		def is_insert_bad?(article)
			!article.instance_of?(Article) || exists?(article)
		end

		def salvage_bad_insert(article, original_index)
			if article.is_a?(ExceptionArticle)
				article
			elsif !article.is_a?(Article)
				ExceptionArticle.new("Not an Article", original_index)
			else
				ExceptionArticle.new("Duplicate Article", original_index)		
			end
		end

		def is_article_bad?(id, article)
			!article.is_a?(Article) ||
			article.title == "" ||
			is_date_bad?(article) ||
			is_url_bad?(id, article)
		end

		def is_date_bad?(article)
			return false if article.date.is_a?(Date)
			Date.parse(article.date).is_a?(Date) rescue return true
		end

		def is_url_bad?(id, article)
			return true if url_is_duplicate?(id, article.url)
			return false if article.url.is_a?(URI)
			URI(article.url).is_a?(URI) rescue return true
		end

		def url_is_duplicate?(id, url)
			@articles.each.with_index do | a,i | 
				return true if (a.url.to_s == url.to_s) && (i != id - 1) 
			end
			false
		end
	end
end