require 'spec_helper'

module ArticleManager
	describe ArticleRecordParser do
		let (:articlerecordparser) {ArticleRecordParser.new}
		let (:articlehelper) {ArticleManagerHelper.new}

		describe "#parse" do
			it "returns an Article instance for a valid article row" do
				articles = articlerecordparser.parse(articlehelper.get_article_record([:testArticle1]))
				articles[0].should be_a(Article)
			end

			it "returns the correct Article instance for a valid article row" do
				articles = articlerecordparser.parse(articlehelper.get_article_record([:testArticle1]))
				articles[0].title.should == articlehelper.get_article_title(:testArticle1)
			end

			it "returns an Article with a trimmed title" do
				articles = articlerecordparser.parse(articlehelper.get_article_record([:testArticleWithSpaces]))
				articles[0].title.should == articlehelper.get_article_title(:testArticleWithSpaces)
			end

			it "returns an empty array if the Article Record is empty" do
				articles = articlerecordparser.parse(articlehelper.get_article_record([]))
				articles.should be_empty
			end

			it "returns an array with the correct number of Articles in an article record" do
				articles = articlerecordparser.parse(articlehelper.get_article_record([:testArticle1, :testArticle2]))
				articles.length.should == 2
			end

			it "returns an array with Articles in the same order as in the article record" do
				articles = articlerecordparser.parse(articlehelper.get_article_record([:testArticle1, :testArticle2]))
				articles[0].title.should == articlehelper.get_article_title(:testArticle1)
				articles[1].title.should == articlehelper.get_article_title(:testArticle2)
			end

			it "returns an ExceptionArticle for an Article Record with to few values" do
				articles = articlerecordparser.parse(articlehelper.get_article_record([:testArticleWithTooFewFields]))
				articles[0].should be_a(ExceptionArticle)
			end
		end
	end
end