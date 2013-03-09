require 'spec_helper'

module ArticleManager
	describe Controller do
		
		let (:output) {double('output')}
		let (:controller) {Controller.new(output)}
		let (:helper) {ArticleHelper.new}

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

	class ArticleHelper
		def initialize
			@articles = {testArticle1: "2013-01-01,Article Management 101,http://www.example.org/1/,Tutorial,For Beginners.",
									testArticle2: "2013-01-02,Advanced Article Management,http://www.example.org/2/,Tutorial,For Experts.",
									testArticleWithSpaces: " 2013-01-03 , Subtle Article Management , http://www.example.org/3/ , Guide , For Experts. ",
									testArticleWithTooFewFields: "Bad Practices for Article Management, http://www.example.org/4/, For Everyone."}
			@titles = {testArticle1: "Article Management 101",
									testArticle2: "Advanced Article Management",
									testArticleWithSpaces: "Subtle Article Management",
									testArticleWithTooFewFields: "Error, Row 1: An Article Record row needs 5 values."}
			@empty_article_record = "Date,Title,URL,Categories,Description"
			@response_header = "Added Articles:"
			@empty_response = "No Articles Added: Empty Article Record."
		end

		def get_article_record(articles=[])
			article_record = articles.empty? ? @empty_article_record : @empty_article_record
			articles.each do |article|
				article_record << "\n#{@articles[article]}"
			end
			article_record
		end

		def get_article_record_with_empty_row(articles=[])
			article_record = get_article_record(articles)
			article_record.split("\n").insert(1,"\n").join
		end

		def get_article_response(articles=[])
			response = articles.empty? ? @empty_response : "#{@response_header}\n"
			articles.each do |article|
				response << "\t#{@titles[article]}\n"
			end
			response
		end
	end
end