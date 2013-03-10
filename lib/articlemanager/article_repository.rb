module ArticleManager
	class ArticleRepository
		def initialize
			@internal_storage = []
		end

		def add_array(article_array)
			article_array.select{ | x | x.instance_of?(Article) }.each { | article | add(article) }
		end

		def add(article)
			@internal_storage << article
			article
		end

		def find_all
			return @internal_storage
		end
	end
end