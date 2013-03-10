Given(/^an empty Article Repository$/) do
  @controller = ArticleManager::Controller.new(output, ArticleManager::ArticleRecordParser.new, ArticleManager::ArticleRepository.new)
end

Given(/^an Article Repository with articles in it$/) do
	@article_record_row = "2012-04-05,I Exist,http://www.existing.com/,White Paper,Existential ramblings"
	@article = ArticleManager::Article.new(@article_record_row.split(","))
	@controller = ArticleManager::Controller.new(output, ArticleManager::ArticleRecordParser.new, ArticleManager::ArticleRepository.new([@article]))
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


Then(/^I should only see "No Articles Added: Empty Article Record."$/) do 
	output.messages.should include("No Articles Added: Empty Article Record.")
end

Then(/^I should see "([^"]*)"$/) do | message |
  output.messages.should include(message.gsub(/\\n/,"\n").gsub(/\\t/, "\t"))
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