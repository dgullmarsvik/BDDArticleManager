Feature: List the Details of an Article

	As a manager of articles
	I want to be able to list of a specific Article in my Article Repository
	So that I can see that the Article is up to date and make changes and delete the Article of necessary

	Scenario Outline: Article Respository with several articles in it
		Given an Article Repository with several articles in it
		When I list the details for article "<id>"
		Then I should see "<output>"

		Scenarios: List Details
			|id|output|
			|0|No article with ID: 0 exists|
			|1|List Article With ID: 1|
			|2|List Article With ID: 2|
			|3|List Article With ID: 3|
			|4|List Article With ID: 4|
			|5|List Article With ID: 5|
			|6|No article with ID: 6 exists|
			|a|Illegal ID: Only numbers are allowed.|