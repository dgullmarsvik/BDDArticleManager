require 'spec_helper'

module ArticleManager
	describe ArticleRepository do
		let (:article_repository) {ArticleRepository.new}

		describe "#add_array" do
			it "adds all Articles in the array to the repository" do
				article_array = [Article.new(["2012-01-01", "Title 1", "http://example.org/1/", "", ""]), Article.new(["2012-01-02", "Title 2", "http://example.org/2/", "", ""])]
				article_repository.add_array(article_array)
				stored_articles = article_repository.find_all
				stored_articles.length.should == 2
			end

			it "does not add ExceptionArticles to the repository" do
				article_array = [Article.new(["2012-01-01", "Title 1", "http://example.org/1/", "", ""]), ExceptionArticle.new("Title Missing", 2)]
				article_repository.add_array(article_array)
				stored_articles = article_repository.find_all
				stored_articles.length.should == 1
			end

			it "returns an array with the added Articles"

		end
	end
end