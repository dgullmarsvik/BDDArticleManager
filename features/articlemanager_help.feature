Feature: Help

	As a manager of articles
	I want to find out what commands are available
	So that I can use ArticleManager without consulting any documentation or memorizing the commands

	Scenario: Help Screen
		Given that ArticleManager is running
		When I issue the "help" command
		Then I should see the help screen

	Scenario Outline: Quick Help
		Given that ArticleManager is running
		And an empty article record
		And an empty Article Repository
		When I issue the "<command>" command
		Then I should see "<quick_help>"

		Scenarios: Different Quick Help Lines
		|command|quick_help|
		|import|\n\n[l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit|
		|list|\n\n[l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit|
		|details|\n\n[d]: Delete [u]: Update [e]: Exit [h]/[?]: Help [q]: Quit|