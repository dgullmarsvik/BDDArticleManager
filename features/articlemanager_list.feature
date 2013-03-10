Feature: List the contents of an Article Repository

	As a manager of articles
	I want to be able to list all Articles in my Article Repository
	So that I can keept track of Articles and perform different operations on them

	Scenario: Empty Article Respository
		Given an empty Article Repository
		When I list all articles
		Then I should see "\nNo Articles in Article Repository."

	Scenario: Article Respository with several articles in it
		Given an Article Repository with several articles in it
		When I list all articles
		Then I should see "\nArticles:\n\t[1]: I Exist 1 - http://www.existing.com/1/\n\t[2]: I Exist 2 - http://www.existing.com/2/\n\t[3]: I Exist 3 - http://www.existing.com/3/\n\t[4]: I Exist 4 - http://www.existing.com/4/\n\t[5]: I Exist 5 - http://www.existing.com/5/"

	# The point of this scenario is that each article should
	# have a unique identifier between brackets like so: "[id]:"
	# 
	Scenario: Individual Articles need a unique identifier in order for the user to be able to perform actions on them
		Given an Article Repository with articles in it
		When I list all articles
		Then I should see "\nArticles:\n\t[1]: I Exist - http://www.existing.com/"