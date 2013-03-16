require 'spec_helper'

module ArticleManager
	describe Article do
		let(:article_array) {["2012-12-31", "Title", "http://example.org", "categories", "description"]}
		let(:article) {Article.new(article_array)}
		
		describe "#new" do
			it "gives a new article the default value for id" do
				article.id.should == -1
			end

			it "gives a new article the correct value for title" do
				article.title.should == "Title"
			end

			it "gives a new article the correct value for url" do
				article.url.should == URI("http://example.org")
			end

			it "gives a new article the correct value for description" do
				article.description.should == "description"
			end

			it "gives a new article the correct value for categories" do
				article.categories.should == "categories"
			end

			context "Exceptions" do
				it "raises Exception with 'Too Few Values' when there are not atleast 4 fields" do
					expect {Article.new(["Title"])}.to raise_error("Too Few Values")
				end
				
				it "raises Exception with 'Empty Row' when there are no fields" do
					expect {Article.new(["\n"])}.to raise_error("Empty Row")
				end
				
				it "raises Exception with 'Not A Valid URL' when the URL field is not valid" do
					expect {Article.new(["2012-01-01","Title","Not a valid url","Tutorial","Description"])}.to raise_error(URI::InvalidURIError)	
				end
				
				it "raises Exception with 'Not A Valid Date' when the Date field is not valid" do
					expect {Article.new(["Not a valid date","Title","https://example.org/1/","Tutorial","Description"])}.to raise_error(ArgumentError)
				end
				
				it "raises Exception with 'Missing Title' when the Title field is missing" do
					expect {Article.new(["2012-01-01","","https://example.org/1/","Tutorial","Description"])}.to raise_error("Missing Title")
				end

				it "raises Exception with 'Missing Title' when the Title field is missing" do
					expect {"asdf".count}.to raise_error("Missing Title")
				end				
			end
		end

		describe "#to_s" do
			it "returns a formatted string representing the Article" do
				article.to_s.should == "'Title' - url: 'http://example.org'\n\tDescription: description\n\tCategories: categories\n\tDate: 2012-12-31"
			end

		end
	end
end