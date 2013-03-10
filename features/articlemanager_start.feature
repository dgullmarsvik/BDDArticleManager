Feature: Start Program

	As a manager of articles
	I want to get feedback when ArticleManager has started
	So that I know when I can start using ArticleManager

	Scenario: Quit Program
		Given that ArticleManager is not running
		When I start ArticleManager
		Then I should see "\nWelcome to ArticleManager!\n\n"
		And I should see the help screen