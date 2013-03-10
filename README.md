BDDArticleManager
=================

Description: A Simple program showcasing Cucumber + RSpec

Author: David Gullmarsvik

Layout:
features: Cucumber features
spec: RSpec Examples
lib: Source Code
	ArticleRepository: Wrapper around the (non-existant) Persistance layer.
	
	Article: Represents an article
	
	ExceptionArticle: Used for Error Handling
	
	ArticleRecordParser: Used to parse ArticleRecords (CSV-files)
	
	Controller: Input/Output Manager

Notes:

Som features of the Program I'm not satisfied with:

ExceptionArticle for ErrorHandling: Not a good solution, atleast it is somewhat isolated.

Main Switch: Should probably use a command pattern instead.

Controller acting as both View and Controller: Should be split into two classes.

The _specs and step_definitions could use alot of refactoring and more helper methods.

No persistent storage

Add Article Command

Export to CSV Command

Not enough RSpec Examples... ;)