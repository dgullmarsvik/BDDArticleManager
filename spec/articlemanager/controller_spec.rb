require 'spec_helper'

module ArticleManager
	describe Controller do
		
		let (:output) {double('output').as_null_object}
		let (:controller) {Controller.new(output, ArticleRecordParser.new, ArticleRepository.new)}
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
				let(:local_output) {double('output').as_null_object}
				let(:local_repository) {ArticleRepository.new([Article.new("2012-01-01, Title 1,http://www.example.org/1/,Guide,Description".split(","))])}
				let(:local_controller) {Controller.new(local_output, ArticleRecordParser.new, local_repository)}
				
				it "sends the title of an imported article to output" do
					local_output.should_receive(:puts).with(helper.get_article_response([:testArticle2]))
					local_controller.import(helper.get_article_record([:testArticle2]))
				end

				it "sends 'Error, Row 2: Article URL already present in the Article Store' to output when importing an article that already exists in the article store" do
					local_output.should_receive(:puts).with(helper.get_article_response([:testArticleAlreadyPresent]))
					local_controller.import(helper.get_article_record([:testArticle1]))
				end
			end
		end

		describe "#list_all_articles" do
			context "Empty Article Repository" do
				it "sends 'No Articles in Article Repository' to output" do
					output.should_receive(:puts).with("No Articles in Article Repository.")
					controller.list_all_articles
				end
			end

			context "Article Repository with Articles in it" do
				let(:local_output) {double('output').as_null_object}
				let(:local_repository) {ArticleRepository.new([Article.new("2012-01-01, Title 1,http://www.example.org/1/,Guide,Description".split(","))])}
				let(:local_controller) {Controller.new(local_output, ArticleRecordParser.new, local_repository)}
				
				it "sends listing of articles to output" do
					local_output.should_receive(:puts).with("\nArticles:\n\t[1]: Title 1 - http://www.example.org/1/")
					local_controller.list_all_articles
				end

				# This example is the same as the example above it at
				# the moment. They should be refactored to be different.
				#
				# The point of this example is that each article should
				# have a unique identifier between brackets like so: "[id]:"
				# 
				it "sends an id with each article" do
					local_output.should_receive(:puts).with("\nArticles:\n\t[1]: Title 1 - http://www.example.org/1/")
					local_controller.list_all_articles
				end
			end
		end

		describe "#list_details_for_article_with_id" do
			let(:local_output) {double('output').as_null_object}
			let(:local_repository) {ArticleRepository.new([Article.new("2012-01-01, Title 1,http://www.example.org/1/,Guide,Description".split(",")),
																										 Article.new("2012-01-02, Title 2,http://www.example.org/2/,Tutorial,Description 2".split(","))])}
			let(:local_controller) {Controller.new(local_output, ArticleRecordParser.new, local_repository)}	

			it "sends details for an existing article to output" do
					local_output.should_receive(:puts).with("\nDetails For: 'Title 1' - url: 'http://www.example.org/1/'\n\tDescription: Description\n\tCategories: Guide\n\tDate: 2012-01-01")
					local_controller.list_details_for_article_with_id(1)
			end

			it "sends details for another existing article to output" do
				local_output.should_receive(:puts).with("\nDetails For: 'Title 2' - url: 'http://www.example.org/2/'\n\tDescription: Description 2\n\tCategories: Tutorial\n\tDate: 2012-01-02")
				local_controller.list_details_for_article_with_id(2)
			end

			it "sends error message to output for id 0" do
				local_output.should_receive(:puts).with("\nError: Only positive integers are allowed to be ids.")
				local_controller.list_details_for_article_with_id(0)
			end

			it "sends error message to output for negative id" do
				local_output.should_receive(:puts).with("\nError: Only positive integers are allowed to be ids.")
				local_controller.list_details_for_article_with_id(-1)
			end

			it "sends error message to output for non-existant article" do
				local_output.should_receive(:puts).with("\nError: No article with ID: '3' exists.")
				local_controller.list_details_for_article_with_id(3)
			end

			it "sends error message to output for non-integer, non-positive, ids to output" do
				local_output.should_receive(:puts).with("\nError: Only positive integers are allowed to be ids.")
				local_controller.list_details_for_article_with_id("a")
			end
		end

		describe "delete_article_with_id" do
			let(:local_output) {double('output').as_null_object}
			let(:local_repository) {ArticleRepository.new([Article.new("2012-01-01, Title 1,http://www.example.org/1/,Guide,Description".split(",")),
																										 Article.new("2012-01-02, Title 2,http://www.example.org/2/,Tutorial,Description 2".split(","))])}
			let(:local_controller) {Controller.new(local_output, ArticleRecordParser.new, local_repository)}	

			it "sends details for an existing article to output" do
					local_output.should_receive(:puts).with("\nDeleted: 'Title 1' - url: 'http://www.example.org/1/'\n\tDescription: Description\n\tCategories: Guide\n\tDate: 2012-01-01")
					local_controller.delete_article_with_id(1)
			end

			it "sends details for another existing article to output" do
				local_output.should_receive(:puts).with("\nDeleted: 'Title 2' - url: 'http://www.example.org/2/'\n\tDescription: Description 2\n\tCategories: Tutorial\n\tDate: 2012-01-02")
				local_controller.delete_article_with_id(2)
			end

			it "sends error message to output for id 0" do
				local_output.should_receive(:puts).with("\nError: Only positive integers are allowed to be ids.")
				local_controller.delete_article_with_id(0)
			end

			it "sends error message to output for negative id" do
				local_output.should_receive(:puts).with("\nError: Only positive integers are allowed to be ids.")
				local_controller.delete_article_with_id(-1)
			end

			it "sends error message to output for non-existant article" do
				local_output.should_receive(:puts).with("\nError: No article with ID: '3' exists.")
				local_controller.delete_article_with_id(3)
			end

			it "sends error message to output for non-integer, non-positive, ids to output" do
				local_output.should_receive(:puts).with("\nError: Only positive integers are allowed to be ids.")
				local_controller.delete_article_with_id("a")
			end
		end

		describe "#start" do
			it "sends greeting message to output" do
				output.should_receive(:puts).with("\nWelcome to ArticleManager!\n\n")
				controller.start
			end

			it "sends help screen message to output" do
				output.should_receive(:puts).with("\n\nAvailable Commands for ArticleManager:\n\t[l]: List Articles \n\t[#]: List Details for Article # (# is the id for the article)\n\t\tCommands in the List Details Screen:\n\t\t\t[d]: Delete Article\n\t\t\t[u]: Update Article\n\t\t\t[e]: Exit from the List Details Screen\n\t([a]: Add Article)\n\t[i]: Import Articles\n\t([e]: Export Articles)\n\t[q]: Quit\n\t[h]/[?]: Help (This screen)\n\n\tTo enter a command: enter the corresponding character and press enter")
				controller.start
			end

		end

		describe "#quit" do
			it "sends exit message to output" do
				output.should_receive(:puts).with("\nClosing down ArticleManager...\n")
				controller.quit
			end

			it "quits running" do
				controller.quit
				controller.shutdown.should == true
			end
		end

		describe "#help" do
			it "sends the help screen to output" do
				output.should_receive(:puts).with("\n\nAvailable Commands for ArticleManager:\n\t[l]: List Articles \n\t[#]: List Details for Article # (# is the id for the article)\n\t\tCommands in the List Details Screen:\n\t\t\t[d]: Delete Article\n\t\t\t[u]: Update Article\n\t\t\t[e]: Exit from the List Details Screen\n\t([a]: Add Article)\n\t[i]: Import Articles\n\t([e]: Export Articles)\n\t[q]: Quit\n\t[h]/[?]: Help (This screen)\n\n\tTo enter a command: enter the corresponding character and press enter")
				controller.help
			end
		end

		describe "#quickhelp" do
			context "list" do
				it "sends normal quickhelp to output" do
					output.should_receive(:puts).with("\n\n[l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit")
					controller.list_all_articles
				end
			end

			context "details" do
				it "sends details quickhelp to output" do
					output.should_receive(:puts).with("\n\n[d]: Delete [u]: Update [e]: Exit [h]/[?]: Help [q]: Quit")
					controller.import(helper.get_article_record([:testArticle1]))
					controller.list_details_for_article_with_id(1)
				end
			end

			context "import" do
				it "sends normal quickhelp to output" do
					output.should_receive(:puts).with("\n\n[l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit")
					controller.import(helper.get_article_record([:testArticle1]))
				end
			end
		end
	end
end