BDDArticleManager
=================

Description: A Simple program showcasing Cucumber + RSpec

Author: David Gullmarsvik

To run the program
--------------------

Go to /bin-directory

Mac/Linux, type: ./articlemanager (make sure to 'chmod +x articlemanager' first)

Windows, type: articlemanager.bat (not tested... ;)

The articlemanager script is only supposed to showcase the program.

Some functionality in the source code is not reflected in the script. E.g. the import function has a lot of test code, but is use statically in the script.

The code in the bin/articlemanager-script does not have any tests. This was due to time constraints.

Layout:
---------
- features: Cucumber features
- spec: RSpec Examples
- lib: Ruby Source Code
	- ArticleRepository: Wrapper around the (non-existant) database.
	
	- Article: Represents an article (title, url, etc)
	
	- ExceptionArticle: Used for Error Handling
	
	- ArticleRecordParser: Used to parse ArticleRecords (CSV-files)
	
	- Controller: Input/Output Manager

Features I'm not satisfied with
---------------------------------

- [ ] ExceptionArticle for ErrorHandling: Not a good solution, and not enough isolation for a bad solution.

- [ ] Main Switch: Should probably use a command pattern instead.

- [ ] Controller acting as both View and Controller: Should be split into two classes.

- [ ] The _specs and step_definitions could use alot of refactoring and more helper methods.

- [ ] No persistent storage

- [ ] No Add Article Command

- [ ] No Export to CSV Command

- [ ] Some code duplication.

- [ ] Not enough RSpec Examples... ;)