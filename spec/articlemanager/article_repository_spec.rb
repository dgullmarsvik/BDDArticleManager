require 'spec_helper'

module ArticleManager
	describe ArticleRepository do
		let (:article_repository) {ArticleRepository.new}
		let (:article_array) {[Article.new(["2012-01-01", "Title 1", "http://example.org/1/", "", ""]), Article.new(["2012-01-02", "Title 2", "http://example.org/2/", "", ""])]}

		describe "#add_array" do
			it "adds all Articles in the array to the repository" do
				article_repository.add_array(article_array)
				stored_articles = article_repository.find_all
				stored_articles.length.should == 2
			end

			it "does not add ExceptionArticles to the repository" do
				local_article_array = [Article.new(["2012-01-01", "Title 1", "http://example.org/1/", "", ""]), ExceptionArticle.new("Title Missing", 2)]
				article_repository.add_array(local_article_array)
				stored_articles = article_repository.find_all
				stored_articles.length.should == 1
			end

			it "returns an array with the added Articles" do
				returned_article_array = article_repository.add_array(article_array)
				returned_article_array.should == article_array
			end

			it "returns an array with ExceptionArticles for Articles that are already in the repository" do
				article_repository.add_array(article_array)
				returned_array = article_repository.add_array(article_array)
				returned_array[0].should be_instance_of(ExceptionArticle)
				returned_array[1].should be_instance_of(ExceptionArticle)
			end

		end
	end
end