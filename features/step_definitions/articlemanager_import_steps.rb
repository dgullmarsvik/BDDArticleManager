Given(/^an empty ArticleStore$/) do
  @controller = ArticleManager::Controller.new(output)
end

Given(/^a article record with (\d+) valid article titled "(.*?)"$/) do | count, title |
  @article_record = empty_article_record
  @article_record += "2013-01-01, #{title}, http://example.org/2/,Tutorial,Very Descriptive Description\n"
end

Given(/^an article record with (\d+) "(.*?)"$/) do | count, article |
	@article_record = empty_article_record
	@article_record += article
end	

Given(/^an article record with "(.*?)"$/) do | articles |
end

Given(/^an empty article record$/) do
	@article_record = empty_article_record
end

When(/^I import the article record$/) do
	@controller.import(@article_record)
end

Then(/^I should only see "No Articles Added: Empty Article Record."$/) do 
	output.messages.should include("No Articles Added: Empty Article Record.")
end

Then(/^I should see "([^"]*)"$/) do | message |
  output.messages.should include(message.gsub(/\\n/,"\n").gsub(/\\t/, "\t"))
end

	#


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