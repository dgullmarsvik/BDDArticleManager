require 'uri'
require 'date'

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
			@internal_storage.push(article).last
		end

		def exists?(article)
			!find_by_url(article.url.to_s).nil?
		end

		def find_by_url(url)
			@internal_storage.select{ | x | x.url.to_s == URI(url).to_s }.first
		end

		def find_by_id(id)
			if is_id_not_valid?(id)
				recover_from_invalid_id(id)
			else
				@internal_storage[id - 1]
			end
		end

		def delete(id)
			if is_id_not_valid?(id)
				recover_from_invalid_id(id)
			else
				@internal_storage.delete_at(id - 1)
			end
		end

		def update_article_with_id(id, article)
			if is_id_not_valid?(id)
				recover_from_invalid_id(id)
			elsif !is_article_valid_for_update?(id, article)
				recover_from_invalid_article_update(id, article)
			else
				@internal_storage[id-1] = article
			end
		end

		def find_all
			return @internal_storage
		end

		private 
		def is_id_not_valid?(id)
			!id.is_a?(Integer) || id <= 0 || id > @internal_storage.length
		end

		def recover_from_invalid_id(id)
			if !id.is_a?(Integer) || id <= 0
				ExceptionArticle.new("ID Is Non-Positive-Integer", id)
			elsif id > @internal_storage.length
				ExceptionArticle.new("Non-Existant Article", id)
			end
		end

		def is_article_valid_for_insertion?(article)
			article.instance_of?(Article) && !exists?(article)
		end

		def is_article_valid_for_update?(id, article)
			article.instance_of?(Article) && 
			@internal_storage.length >= id &&
			article.title != "" &&
			is_article_date_valid?(article) &&
			is_article_url_valid?(id, article)
		end

		def is_article_date_valid?(article)
			return true if article.date.instance_of?(Date)
			begin
				Date.parse(article.date)
			rescue
				return false
			end
			true
		end

		def is_article_url_valid?(id, article)
			return false if url_already_exist?(id, article.url)
			return true if article.url.instance_of?(URI)
			begin
				URI(article.url)
			rescue
				return false
			end
			true
		end

		def url_already_exist?(original_index, url)
			exist = false
			@internal_storage.each.with_index do | a,i | 
				exist = true if (a.url.to_s == url.to_s) && (i != original_index - 1) 
			end
			exist
		end

		def recover_from_invalid_article_update(original_index,article)
			if article.instance_of?(ExceptionArticle)
				article
			elsif is_id_not_valid?(original_index)
				ExceptionArticle.new("ID Is Non-Positive-Integer", original_index)
			elsif !article.instance_of?(Article)
				ExceptionArticle.new("Not an Article", original_index)
			elsif !is_article_date_valid?(article)
				ExceptionArticle.new("Not A Valid Date", original_index)
			elsif !is_article_url_valid?(original_index, article)
				ExceptionArticle.new("Not A Valid URL", original_index)
			elsif article.title == ""
				ExceptionArticle.new("Missing Title", original_index)
			else
				raise article.to_s + ":" + "#{original_index.to_i}"
				ExceptionArticle.new("Duplicate Article", original_index)		
			end
		end

		def recover_from_invalid_article(article, original_index)
			if article.instance_of?(ExceptionArticle)
				article
			elsif !article.instance_of?(Article)
				ExceptionArticle.new("Not an Article", original_index)
			else
				ExceptionArticle.new("Duplicate Article", original_index)		
			end
		end
	end
end