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
				returned_article_array[0].url.to_s == article_array[0].url.to_s
				returned_article_array[1].url.to_s == article_array[1].url.to_s
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
				article.url.should == URI("http://example.org/2/")
			end

			it "returns nil if no article in the repsoitory matches the url" do
				article_repository.add_array(article_array)
				article = article_repository.find_by_url("http://example.org/3/")
				article.should be_nil
			end
		end

		describe "#find_all" do
			it "returns all articles in the repository" do
				article_repository.add_array(article_array)
				found_articles = article_repository.find_all
				found_articles.should == article_array
			end

			it "returns an empty array if no articles are stored in the repsitory" do
				found_articles = article_repository.find_all
				found_articles.should be_empty
			end
		end

		describe "#add" do
			it "adds an article to the repository and returns the added article" do
				article_to_be_added = Article.new(["2012-03-03", "Title 1", "http://example.org/7/", "", ""])
				added_article = article_repository.add(article_to_be_added)
				article_to_be_added.url.to_s.should == added_article.url.to_s
			end

			it "returns an ExcpetionArticle if an article with the same url already exists in the repository" do
				article_repository.add_array(article_array)
				article_to_be_added = Article.new(["2012-03-03", "Title 1", "http://example.org/2/", "", ""])
				added_article = article_repository.add(article_to_be_added)
				added_article.should be_instance_of(ExceptionArticle)
			end

			it "returns an ExceptionArticle if passed a non-Article/ExceptionArticle-object" do
				added_article = article_repository.add("should get error")
				added_article.should be_instance_of(ExceptionArticle)
			end
		end
	end
end