module ArticleManager
  class Controller
  	def initialize(output, article_parser, article_repository)
  		@output = output
      @article_parser = article_parser
      @article_repository = article_repository
  	end

    def start
      @output.puts(format_greeting_response)
      @output.puts(format_help_screen_response)
    end

    def help
      @output.puts(format_help_screen_response)
    end

    def quit
      @output.puts(format_quit_response)
      @shutdown = true
    end

    def shutdown
      @shutdown ||= false
    end

  	def import(article_record)
  		parsed_articles = @article_parser.parse(article_record)
      imported_articles = @article_repository.add_array(parsed_articles)
      @output.puts(format_import_response(imported_articles))
      @output.puts(format_normal_quickhelp_response)
  	end

    def list_all_articles
      articles = @article_repository.find_all
      @output.puts(format_list_response(articles))
      @output.puts(format_normal_quickhelp_response)
    end

    def list_details_for_article_with_id(article_id)
      article = @article_repository.find_by_id(article_id)
      @output.puts(format_details_response("Details For",article))
      @output.puts(format_details_quickhelp_response)
    end

    def delete_article_with_id(article_id)
      article = @article_repository.delete(article_id)
      @output.puts(format_details_response("Deleted",article))
      @output.puts(format_details_quickhelp_response)
    end

  	private

  	def format_import_response(articles)
  		response = articles.length > 0 ? "Added Articles:\n" : "No Articles Added: Empty Article Record."
      response += articles.collect { | article | "\t#{article.title}\n" }.join
  	end

    def format_list_response(articles)
      response = articles.length > 0 ? "\nArticles:" : "No Articles in Article Repository."
      response += articles.collect.with_index { | article, i | "\n\t[#{(i + 1).to_s}]: #{article.title} - #{article.url}" }.join
    end

    def format_details_response(prefix,article)
      if article.is_a?(ExceptionArticle)
        "\n#{article.to_details}"
      else
        "\n#{prefix}: #{article.to_details}"
      end
    end

    def format_quit_response
      "\nClosing down ArticleManager...\n"
    end

    def format_greeting_response
      "\nWelcome to ArticleManager!\n\n"
    end

    def format_help_screen_response
      "\n\nAvailable Commands for ArticleManager:\n\t[l]: List Articles \n\t[#]: List Details for Article # (# is the id for the article)\n\t\tCommands in the List Details Screen:\n\t\t\t[d]: Delete Article\n\t\t\t[u]: Update Article\n\t\t\t[e]: Exit from the List Details Screen\n\t([a]: Add Article)\n\t[i]: Import Articles\n\t([e]: Export Articles)\n\t[q]: Quit\n\t[h]/[?]: Help (This screen)\n\n\tTo enter a command: enter the corresponding character and press enter"
    end

    def format_normal_quickhelp_response
      "\n\n[l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit"
    end

    def format_details_quickhelp_response
      "\n\n[d]: Delete [u]: Update [e]: Exit [h]/[?]: Help [q]: Quit"
    end
  end
end

#ArticleManager
#  v start
#  v import
#  v list_articles
#  v details
#   x remove
#   x update
#   x exit
#  v quit
#  v help: Available Commands for ArticleManager:
#            [l]: List Articles 
#            [#]: List Details for Article # (# is the id for the article)
#               Commands in the List Details Screen:
#                 [d]: Delete Article
#                 [u]: Update Article
#                 [e]: Exit from the List Details Screen
#            ([a]: Add Article)
#            [i]: Import Articles
#            ([e]: Export Articles)
#            [q]: Quit
#            [h]/[?]: Help (This screen)
#
#           To enter a command: enter the corresponding character and press enter
#           
#   v qcmd    [l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit
#             [d]: Delete [u]: Update [e]: Exit [h]/[?]: Help [q]: Quit
#   v input   Enter Command: 
#
#  x add
#  x export

# Förmodligen 3-4 timmars refactoring ifrån en lösning jag är nöjd med
# 
# Primary concerns:
#
# ExceptionArticle känns inte som en bra lösning
# Jag har inte funderat jätte mycket på namngivning av variabler och metoder
# Både Features och Specs känns stökiga och otympliga att jobba med just nu - jag hade lagt mestadelen av tiden på refactoring här
# Jag saknar Scenarios och Unit Tests för att känna mig riktigt trygg med testerna
# Switch-satsen för att hantera kommandon känns inte som en bra lösning
#
# Features som saknas:
#
# Export / Persistant Storage
# 