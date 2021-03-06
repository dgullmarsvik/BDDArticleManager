Feature: Article Record Import

	As a manager of articles
	I want to be able to import article records to my Article Repository
	So that I can keep my Article Repository up to date

	
	Scenario: Importing an empty article record
		Given an empty Article Repository
		And an empty article record
		When I import the article record
		Then I should see "\nNo Articles in Article Record."


	Scenario Outline: Importing an article record with 1 article
		Given an empty Article Repository	
		And an article record with 1 "<article>"
		When I import the article record
		Then I should see "<output>"

		Scenarios: Valid article
			|article|output|
			|2013-01-01,Title 1,http://example.org/4/,Tutorial,Description 1|\nAdded Articles:\n\tTitle 1|
			|2012-02-02,Title 2,http://example.org/4/,Guide,Description 2|\nAdded Articles:\n\tTitle 2|

		Scenarios: Not a valid article: Too few values
			|article|output|
			|Title,http://example.org/4/,Description|\nAdded Articles:\n\tError, Row 1: An Article Record row needs 5 values.|
			|2012-02-02,Title,http://example.org/4/,Description|\nAdded Articles:\n\tError, Row 1: An Article Record row needs 5 values.|

		Scenarios: Not a valid article: Missing Title
			|article|output|
			|2013-01-01,,http://example.org/4/,Tutorial,Description 1|\nAdded Articles:\n\tError, Row 1: Missing title for article.|

		Scenarios: Not a valid article: Not a valid date
			|article|output|
			|2013-01-,Title 1,http://example.org/4/,Tutorial,Description 1|\nAdded Articles:\n\tError, Row 1: Not a valid Date.|
			|2012-02-aa,Title 2,http://example.org/4/,Guide,Description 2|\nAdded Articles:\n\tError, Row 1: Not a valid Date.|

		Scenarios: Not a valid article: Not a valid URL
			|article|output|
			|2012-02-01,Title 2,invalid url,Guide,Description 2|\nAdded Articles:\n\tError, Row 1: Not a valid URL.|

	Scenario Outline: Importing several articles
		Given an empty Article Repository	
		And an article record with "<articles>"
		When I import the article record
		Then I should see "<output>"

		Scenarios: 2 valid articles
			|articles|output|
			|2013-01-01,Title 1,http://example.org/4/,Tutorial,Description 1\n2012-02-02,Title 2,http://example.org/5/,Guide,Description 2|\nAdded Articles:\n\tTitle 1\n\tTitle 2|

		Scenarios: One or more invalid articles
			|articles|output|
			|2013-01-01,Title 1,http://example.org/4/,Tutorial,Description 1\nTitle 2,http://example.org/5/,Guide,Description 2|\nAdded Articles:\n\tTitle 1\n\tError, Row 2: An Article Record row needs 5 values.|

	Scenario: Importing an already existing article
		Given an Article Repository with articles in it
		And an article record with an Article that is in the Article Repository
		When I import the article record
		Then I should see "\nAdded Articles:\n\tError, Row 0: Article with identical URL already exists."
	
