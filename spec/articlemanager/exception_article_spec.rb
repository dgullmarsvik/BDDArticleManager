require 'spec_helper'

module ArticleManager
	describe ExceptionArticle do
		describe "#new" do

			it "sets title to too few values" do
				exception_article = ExceptionArticle.new("Too Few Values", 2)
				exception_article.title.should == "Error, Row 2: An Article Record row needs 5 values."
			end
			
			it "sets title to empty row" do
				exception_article = ExceptionArticle.new("Empty Row", 2)
				exception_article.title.should == "Skipping Row 2: Empty Row."
			end

			it "sets title to not a valid URL" do
				exception_article = ExceptionArticle.new("bad URI(is not URI?): invalid url", 2)
				exception_article.title.should == "Error, Row 2: Not a valid URL."
			end

			it "sets title to not a valid Date" do
				exception_article = ExceptionArticle.new("invalid date", 2)
				exception_article.title.should == "Error, Row 2: Not a valid Date."
			end

			it "sets title to Title cannot be empty" do
				exception_article = ExceptionArticle.new("Missing Title", 2)
				exception_article.title.should == "Error, Row 2: Missing title for article."
			end

			it "sets title to Not an Article" do
				exception_article = ExceptionArticle.new("Not an Article",2)
				exception_article.title.should == "Error, Row 2: Object is not an Article."
			end

			it "sets title to Duplicate Article" do
				exception_article = ExceptionArticle.new("Duplicate Article",2)
				exception_article.title.should == "Error, Row 2: Article with identical URL already exists."
			end
		end
	end
end