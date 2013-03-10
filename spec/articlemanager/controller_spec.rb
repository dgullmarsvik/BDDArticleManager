require 'spec_helper'

module ArticleManager
	describe Controller do
		
		let (:output) {double('output')}
		let (:controller) {Controller.new(output, ArticleImporter.new)}
		let (:helper) {ArticleManagerHelper.new}

		describe "#import" do
			context "Empty Article Store" do

				it "sends the title of a single imported article to output" do
					output.should_receive(:puts).with(helper.get_article_response([:testArticle1]))
					controller.import(helper.get_article_record([:testArticle1]))
				end

				it "sends the title of another single imported article to output" do
					output.should_receive(:puts).with(helper.get_article_response([:testArticle2]))
					controller.import(helper.get_article_record([:testArticle2]))
				end

				it "sends a trimmed title of a single imported article with spaces before and after the name" do
					output.should_receive(:puts).with(helper.get_article_response([:testArticleWithSpaces]))
					controller.import(helper.get_article_record([:testArticleWithSpaces]))
				end

				it "sends 'No articles added: Empty Article Store.' if the import file is empty" do
					output.should_receive(:puts).with(helper.get_article_response([]))
					controller.import(helper.get_article_record([]))
				end

				it "sends the titles of all imported articles in an article record" do
					output.should_receive(:puts).with(helper.get_article_response([:testArticle1, :testArticle2]))
					controller.import(helper.get_article_record([:testArticle1, :testArticle2]))
				end

				it "sends 'Error, Row 2: An Article Record row needs 5 values.' for an article row that has too few fields" do
					output.should_receive(:puts).with(helper.get_article_response([:testArticleWithTooFewFields]))
					controller.import(helper.get_article_record([:testArticleWithTooFewFields]))
				end

				it "sends two article titles to output for an Article Record with two articles" do
					output.should_receive(:puts).with(helper.get_article_response([:testArticle1, :testArticle2]))
					controller.import(helper.get_article_record([:testArticle1, :testArticle2]))
				end
			end

			context "Article Store with articles present" do
				it "sends the title of an imported article to output" do
					controller.import(helper.get_article_record([:testArticle1]))
					output.should_receive(:puts).with(helper.get_article_response([:testArticle2]))
					controller.import(helper.get_article_record([:testArticle2]))
				end

				it "sends 'Error, Row 2: Article URL already present in the Article Store' to output when importing an article that already exists in the article store"
			end
		end
	end
end