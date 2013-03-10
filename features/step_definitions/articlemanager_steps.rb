Given(/^that ArticleManager is not running$/) do
end

Given(/^that ArticleManager is running$/) do
	@controller = ArticleManager::Controller.new(output, ArticleManager::ArticleRecordParser.new, ArticleManager::ArticleRepository.new)
	@controller.start 
end

Given(/^an empty Article Repository$/) do
  @controller = ArticleManager::Controller.new(output, ArticleManager::ArticleRecordParser.new, ArticleManager::ArticleRepository.new)
end

Given(/^an Article Repository with articles in it$/) do
	@article_record_row = "2012-04-05,I Exist,http://www.existing.com/,White Paper,Existential ramblings"
	@article = ArticleManager::Article.new(@article_record_row.split(","))
	@controller = ArticleManager::Controller.new(output, ArticleManager::ArticleRecordParser.new, ArticleManager::ArticleRepository.new([@article]))
end

Given(/^an Article Repository with several articles in it$/) do
  @article_record_row_1 = "2012-04-01,I Exist 1,http://www.existing.com/1/,White Paper,Existential ramblings 1"
  @article_record_row_2 = "2012-04-02,I Exist 2,http://www.existing.com/2/,Journal Entry,Existential ramblings 2"
  @article_record_row_3 = "2012-04-03,I Exist 3,http://www.existing.com/3/,Tutorial,Existential ramblings 3"
  @article_record_row_4 = "2012-04-04,I Exist 4,http://www.existing.com/4/,Guide,Existential ramblings 4"
  @article_record_row_5 = "2012-04-05,I Exist 5,http://www.existing.com/5/,Tutorial,Existential ramblings 5"
	@article_array = [ArticleManager::Article.new(@article_record_row_1.split(",")),
										ArticleManager::Article.new(@article_record_row_2.split(",")),
										ArticleManager::Article.new(@article_record_row_3.split(",")),
										ArticleManager::Article.new(@article_record_row_4.split(",")),
										ArticleManager::Article.new(@article_record_row_5.split(","))]
	@controller = ArticleManager::Controller.new(output, ArticleManager::ArticleRecordParser.new, ArticleManager::ArticleRepository.new(@article_array))
end

Given(/^an article record with an Article that is in the Article Repository$/) do
  @article_record = "Date,Title,URL,Categories,Description\n#{@article_record_row}"
end

Given(/^an article record with (\d+) "(.*?)"$/) do | count, article |
	@article_record = empty_article_record
	@article_record += article
end	

Given(/^an article record with "([^"]*)"$/) do | articles |
	@article_record = empty_article_record
	@article_record += articles
end

Given(/^an empty article record$/) do
	@article_record = empty_article_record
end

When(/^I import the article record$/) do
	@controller.import(@article_record)
end

When(/^I list all articles$/) do
  @controller.list_all_articles
end

When(/^I issue the "(.*?)" command$/) do |command|
  case command
  when "help"
  	@controller.help
  when "list"
  	@controller.list_all_articles
  when "details"
  	@controller.list_details_for_article_with_id(1)
  when "import"
  	@controller.import(@article_record)
  else
  	# No command?
  end
end

When(/^I list the details for article "(.*?)"$/) do | article_id |
  converted_id = convert_id(article_id)
  @controller.list_details_for_article_with_id(converted_id)
end

When(/^I delete article "(.*?)"$/) do | article_id |
  converted_id = convert_id(article_id)
  @controller.delete_article_with_id(converted_id)
end


When(/^I start ArticleManager$/) do
	@controller = ArticleManager::Controller.new(output, ArticleManager::ArticleRecordParser.new, ArticleManager::ArticleRepository.new)
  @controller.start
end


When(/^I quit the program$/) do
  @controller.quit
end

Then(/^ArticleManager should close$/) do
	@controller.shutdown.should == true 
end


Then(/^I should only see "No Articles Added: Empty Article Record."$/) do 
	output.messages.should include("No Articles Added: Empty Article Record.")
end

Then(/^I should see "([^"]*)"$/) do | message |
  output.messages.should include(message.gsub(/\\n/,"\n").gsub(/\\t/, "\t"))
end

Then(/^I should see the help screen$/) do
	output.messages.should include("\n\nAvailable Commands for ArticleManager:\n\t[l]: List Articles \n\t[#]: List Details for Article # (# is the id for the article)\n\t\tCommands in the List Details Screen:\n\t\t\t[d]: Delete Article\n\t\t\t[u]: Update Article\n\t\t\t[e]: Exit from the List Details Screen\n\t([a]: Add Article)\n\t[i]: Import Articles\n\t([e]: Export Articles)\n\t[q]: Quit\n\t[h]/[?]: Help (This screen)\n\n\tTo enter a command: enter the corresponding character and press enter")
end

def convert_id(article_id)
	article_id =~ /[[:digit:]]/ ? article_id.to_i : article_id
end

def empty_article_record
	@stockrecord ||= "Date,Title,URL,Categories,Description\n"
end

class Output
	def messages
		@messages ||= []
	end

	def puts(message)
		messages << message
	end
end

def output
	@output ||= Output.new
end