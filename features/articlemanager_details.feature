Feature: List the Details of an Article

	As a manager of articles
	I want to be able to list Details of a specific Article in my Article Repository
	So that I can see that the Article is up to date and make changes and delete the Article if necessary

	Scenario Outline: List Details
		Given an Article Repository with several articles in it
		When I list the details for article "<id>"
		Then I should see "<output>"

		Scenarios: Valid IDs
			|id|output|
			|1|\nDetails For: 'I Exist 1' - url: 'http://www.existing.com/1/'\n\tDescription: Existential ramblings 1\n\tCategories: White Paper\n\tDate: 2012-04-01|
			|2|\nDetails For: 'I Exist 2' - url: 'http://www.existing.com/2/'\n\tDescription: Existential ramblings 2\n\tCategories: Journal Entry\n\tDate: 2012-04-02|
			|3|\nDetails For: 'I Exist 3' - url: 'http://www.existing.com/3/'\n\tDescription: Existential ramblings 3\n\tCategories: Tutorial\n\tDate: 2012-04-03|
			|4|\nDetails For: 'I Exist 4' - url: 'http://www.existing.com/4/'\n\tDescription: Existential ramblings 4\n\tCategories: Guide\n\tDate: 2012-04-04|
			|5|\nDetails For: 'I Exist 5' - url: 'http://www.existing.com/5/'\n\tDescription: Existential ramblings 5\n\tCategories: Tutorial\n\tDate: 2012-04-05|

		Scenarios: Illegal IDs
			|id|output|
			|-1|\nError: Only positive integers are allowed to be ids.|
			|0|\nError: Only positive integers are allowed to be ids.|
			|6|\nError: No article with ID: '6' exists.|
			|a|\nError: Only positive integers are allowed to be ids.|

	Scenario Outline: Delete Article
		Given an Article Repository with several articles in it
		When I delete article "<id>"
		Then I should see "<output>"

		Scenarios: Valid Deletes
			|id|output|
			|1|\nDeleted: 'I Exist 1' - url: 'http://www.existing.com/1/'\n\tDescription: Existential ramblings 1\n\tCategories: White Paper\n\tDate: 2012-04-01|
			|2|\nDeleted: 'I Exist 2' - url: 'http://www.existing.com/2/'\n\tDescription: Existential ramblings 2\n\tCategories: Journal Entry\n\tDate: 2012-04-02|
			|3|\nDeleted: 'I Exist 3' - url: 'http://www.existing.com/3/'\n\tDescription: Existential ramblings 3\n\tCategories: Tutorial\n\tDate: 2012-04-03|
			|4|\nDeleted: 'I Exist 4' - url: 'http://www.existing.com/4/'\n\tDescription: Existential ramblings 4\n\tCategories: Guide\n\tDate: 2012-04-04|
			|5|\nDeleted: 'I Exist 5' - url: 'http://www.existing.com/5/'\n\tDescription: Existential ramblings 5\n\tCategories: Tutorial\n\tDate: 2012-04-05|

		Scenarios: Illegal Deletes
			|id|output|
			|-1|\nError: Only positive integers are allowed to be ids.|
			|0|\nError: Only positive integers are allowed to be ids.|
			|6|\nError: No article with ID: '6' exists.|
			|a|\nError: Only positive integers are allowed to be ids.|

		Scenario Outline: Update Article
		Given an Article Repository with several articles in it
		When I update article with "<id>" "<title>" "<url>" "<categories>" "<description>" "<date>"
		Then I should see "<output>"

		Scenarios: Valid Updates
			|id|title|url|categories|description|date|output|
			|1|I Exist 1a|http://www.existing.com/1/|White Paper|Existential Ramblings 1|2012-04-01|\nUpdated: 'I Exist 1a' - url: 'http://www.existing.com/1/'\n\tDescription: Existential Ramblings 1\n\tCategories: White Paper\n\tDate: 2012-04-01|
			|2|I Exist 2|http://www.existing.com/21/|Journal Entry|Existential Ramblings 2|2012-04-02|\nUpdated: 'I Exist 2' - url: 'http://www.existing.com/21/'\n\tDescription: Existential Ramblings 2\n\tCategories: Journal Entry\n\tDate: 2012-04-02|
			|3|I Exist 3|http://www.existing.com/3/|Journal Entry|Existential Ramblings 3|2012-04-03|\nUpdated: 'I Exist 3' - url: 'http://www.existing.com/3/'\n\tDescription: Existential Ramblings 3\n\tCategories: Journal Entry\n\tDate: 2012-04-03|
			|4|I Exist 4|http://www.existing.com/4/|Guide|Existential Ramblings 4a|2012-04-04|\nUpdated: 'I Exist 4' - url: 'http://www.existing.com/4/'\n\tDescription: Existential Ramblings 4a\n\tCategories: Guide\n\tDate: 2012-04-04|
			|5|I Exist 5a|http://www.existing.com/51/|Tutorial 5|Existential Ramblings 5a|2012-04-06|\nUpdated: 'I Exist 5a' - url: 'http://www.existing.com/51/'\n\tDescription: Existential Ramblings 5a\n\tCategories: Tutorial 5\n\tDate: 2012-04-06|

		Scenarios: Illegal Updates
			|id|title|url|categories|description|date|output|
			|1|I Exist 1|http://www.existing.com/4/|White Paper|Existential Ramblings 1|2012-04-01|\nError, Row 1: Article with identical URL already exists.|

		Scenario: Exit Details Screen
			Given an Article Repository with articles in it
			And I am on the Details Screen
			When I issue the "exit_details" command
			Then I should see "\n\nExiting Details Screen..."
			And I should see "\n\n[l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit"