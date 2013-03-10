module ArticleManager
	class ArticleRepository
		def initialize
			@internal_storage = []
		end

		def add_array(article_array)
			article_array.each { | article | add(article) }
		end

		def add(article)
			@internal_storage << article
		end

		def find_all
			return @internal_storage
		end
	end
end