Feature: Article Record Import

	As a manager of articles
	I want to be able to import article records to my ArticleStore
	So that I can keep my ArticleStore up to date

	
	Scenario: Importing an empty article record
		Given an empty ArticleStore
		And an empty article record
		When I import the article record
		Then I should only see "No Articles Added: Empty Article Record."


	Scenario Outline: Importing an article record with 1 article
		Given an empty ArticleStore	
		And an article record with 1 "<article>"
		When I import the article record
		Then I should see "<output>"

		Scenarios: Valid article
			|article|output|
			|2013-01-01,Title 1,http://example.org/4/,Tutorial,Description 1|Added Articles:\n\tTitle 1\n|
			|2012-02-02,Title 2,http://example.org/4/,Guide,Description 2|Added Articles:\n\tTitle 2\n|

		Scenarios: Not a valid article: Too few values
			|article|output|
			|Title,http://example.org/4/,Description|Added Articles:\n\tError, Row 1: An Article Record row needs 5 values.\n|
			|2012-02-02,Title,http://example.org/4/,Description|Added Articles:\n\tError, Row 1: An Article Record row needs 5 values.\n|

		Scenarios: Not a valid article: Missing Title
			|article|output|
			|2013-01-01,,http://example.org/4/,Tutorial,Description 1|Added Articles:\n\tError, Row 1: Missing title for article.\n|

		Scenarios: Not a valid article: Not a valid date
			|article|output|
			|2013-01-,Title 1,http://example.org/4/,Tutorial,Description 1|Added Articles:\n\tError, Row 1: Not a valid Date.\n|
			|2012-02-aa,Title 2,http://example.org/4/,Guide,Description 2|Added Articles:\n\tError, Row 1: Not a valid Date.\n|

		Scenarios: Not a valid article: Not a valid URL
			|article|output|
			|2012-02-01,Title 2,invalid url,Guide,Description 2|Added Articles:\n\tError, Row 1: Not a valid URL.\n|

	Scenario Outline: Importing several articles
		Given an empty ArticleStore	
		And an article record with "<articles>"
		When I import the article record
		Then I should see "<output>"

		Scenarios: 2 valid articles
			|articles|output|
			|2013-01-01,Title 1,http://example.org/4/,Tutorial,Description 1\n2012-02-02,Title 2,http://example.org/4/,Guide,Description 2|Added Articles:\n\tTitle 1\n\tTitle 2\n|

		Scenarios: One or more invalid articles
			|articles|output|
			|fail|fail|

	Scenario: Importing an already existing article

	
