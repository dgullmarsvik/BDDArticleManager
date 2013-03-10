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

		describe "#find_by_url" do
			it "returns an article in the repository that matches the url" do
				article_repository.add_array(article_array)
				article = article_repository.find_by_url("http://example.org/2/")
				article.url.should == "http://example.org/2/"
			end

			it "returns nil if no article in the repsoitory matches the url" do
				article_repository.add_array(article_array)
				article = article_repository.find_by_url("http://example.org/3/")
				article.url.should be_nil
			end
		end

		describe "#find_all" do
			it "returns all articles in the repository"

			it "returns an empty array if no articles are stored in the repsitory"
		end

		describe "#add" do
			it "add an article to the repository and returns the added article"

			it "returns an ExcpetionArticle if an article with the same url already exists in the repository"
		end
	end
end