module ArticleManager
	class ArticleRecordParser
		def parse(article_record)
      record_rows = article_record.split("\n")
      record_rows.select{ |x| is_article_row?(x) }.collect.with_index do | article_row, i |
        create_article(article_row, i)
      end
    end

    private
    def create_article(article_row, index)
      begin 
        Article.new(article_row.split(","))
      rescue Exception => e
        recover_from_article_creation_exception(e.message, index)
      end
    end

    def recover_from_article_creation_exception(exception, index)
      ExceptionArticle.new(exception, index + 1)
    end

    def is_article_row?(record_row)
      record_row[0..4] != "Date,"
    end
  end
end