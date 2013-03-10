Feature: List the contents of an Article Repository

	As a manager of articles
	I want to be able to list all Articles in my Article Repository
	So that I can keept track of Articles and perform different operations on them

	Scenario: Empty Article Respository
		Given an empty Article Repository
		When I list all articles
		Then I should see "No Articles in Article Repository."