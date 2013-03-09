require 'spec_helper'

module ArticleManager
	describe ArticleImporter do
		let (:articleimporter) {ArticleImporter.new}
		let (:articlehelper) {ArticleManagerHelper.new}

		describe "#import" do
			context "Empty Article Store" do

				it "returns an Article instance for a valid article row" do
					articles = articleimporter.import(articlehelper.get_article_record([:testArticle1]))
					articles[0].should be_a(Article)
				end

				it "returns the correct Article instance for a valid article row" do
					articles = articleimporter.import(articlehelper.get_article_record([:testArticle1]))
					articles[0].title.should == articlehelper.get_article_title(:testArticle1)
				end

				it "sends a trimmed title of a single imported article with spaces before and after the name"

				it "sends 'No articles added: Empty Article Store.' if the import file is empty"

				it "sends the titles of all imported articles in an article record"

				it "sends 'Error, Row 2: An Article Record row needs 5 values.' for an article row that has too few fields"

				it "sends two article titles to output for an Article Record with two articles"
			end

			context "Article Store with articles present" do
				it "sends the title of an imported article to output"

				it "sends 'Error, Row 2: Article URL already present in the Article Store' to output when importing an article that already exists in the article store"
			end
		end
	end
end