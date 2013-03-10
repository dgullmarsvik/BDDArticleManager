require 'spec_helper'

module ArticleManager
	describe ArticleRepository do
		describe "#add_array" do
			it "adds all Articles in the array to the repository" do
				@article_repository = ArticleRepository.new
				article_array = [Article.new(["2012-01-01", "Title 1", "http://example.org/1/", "", ""]), Article.new(["2012-01-02", "Title 2", "http://example.org/2/", "", ""])]
				@article_repository.add_array(article_array)
				stored_articles = @article_repository.find_all
			end

		end
	end
end