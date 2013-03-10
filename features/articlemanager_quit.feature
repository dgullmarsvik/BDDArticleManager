Feature: Quit Program

	As a manager of articles
	I want to be able to gracefully shut down the program
	So that I don't have to have the program constantly running and I don't lose any data

	Scenario: Quit Program
		Given that ArticleManager is running
		When I quit the program
		Then I should see "\nClosing down ArticleManager...\n"
		And ArticleManager should close

	# TODO: Not needed until data is persisted
	Scenario: Quitting with unsaved data