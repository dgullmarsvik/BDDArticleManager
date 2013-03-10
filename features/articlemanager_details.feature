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
			|-1|\nError: Only positive integers are allowed to be ids.|
			|0|\nError: Only positive integers are allowed to be ids.|
			|1|\nDetails For: 'I Exist 1' - url: 'http://www.existing.com/1/'\n\tDescription: Existential ramblings 1\n\tCategories: White Paper\n\tDate: 2012-04-01|
			|2|\nDetails For: 'I Exist 2' - url: 'http://www.existing.com/2/'\n\tDescription: Existential ramblings 2\n\tCategories: Journal Entry\n\tDate: 2012-04-02|
			|3|\nDetails For: 'I Exist 3' - url: 'http://www.existing.com/3/'\n\tDescription: Existential ramblings 3\n\tCategories: Tutorial\n\tDate: 2012-04-03|
			|4|\nDetails For: 'I Exist 4' - url: 'http://www.existing.com/4/'\n\tDescription: Existential ramblings 4\n\tCategories: Guide\n\tDate: 2012-04-04|
			|5|\nDetails For: 'I Exist 5' - url: 'http://www.existing.com/5/'\n\tDescription: Existential ramblings 5\n\tCategories: Tutorial\n\tDate: 2012-04-05|
			|6|\nError: No article with ID: '6' exists.|
			|a|\nError: Only positive integers are allowed to be ids.|