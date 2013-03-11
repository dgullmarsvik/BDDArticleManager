module ArticleManager
  class Controller
  	def initialize(output, article_parser, article_repository)
  		@output = output
      @article_parser = article_parser
      @article_repository = article_repository
  	end

    def start
      @output.puts(messages[:greeting])
      @output.puts(messages[:help])
    end

    def help
      @output.puts(messages[:help])
    end

    def quit
      @output.puts(messages[:quit])
      @state = :shutdown
    end

    def shutdown
      state == :shutdown
    end

  	def import(article_record)
  		parsed_articles = @article_parser.parse(article_record)
      imported_articles = @article_repository.add_array(parsed_articles)
      @output.puts(import_message(imported_articles))
      @output.puts(messages[state])
  	end

    def list_all_articles
      articles = @article_repository.find_all
      @output.puts(list_message(articles))
      @output.puts(messages[state])
    end

    def list_details_for_article_with_id(article_id)
      article = @article_repository.find_by_id(article_id)
      switch_to_details_screen if valid_article?(article)
      @output.puts(details_message("Details For",article))
      @output.puts(messages[state])
    end

    def delete_article_with_id(article_id)
      article = @article_repository.delete(article_id)
      exit_from_details_screen
      @output.puts(details_message("Deleted",article))
      @output.puts(messages[state])
    end

    def update_article_with_id(id, article)
      article = @article_repository.update_article_with_id(id, article)      
      exit_from_details_screen if !valid_article?(article)
      @output.puts(details_message("Updated",article))
      @output.puts(messages[state])
    end

    def exit_details_screen
      exit_from_details_screen
      @output.puts(messages[:exit_details])
      @output.puts(messages[state])
    end

    def bad_command
      @output.puts(messages[:bad_command])
      @output.puts(messages[state])
    end

    def state
      @state ||= :normal
    end

  	private

  	def import_message(articles)
      message_heading("Added ", "Record", articles) << articles.collect { | article | "\n\t#{article.title}" }.join
  	end

    def list_message(articles)
      message_heading("", "Repository", articles) << articles.collect.with_index { | article, i | "\n\t[#{(i + 1).to_s}]: #{article.title} - #{article.url}" }.join
    end

    def message_heading(prefix,postfix,articles)
      articles.length > 0 ? "\n#{prefix}Articles:" : "\nNo Articles in Article #{postfix}."
    end

    def details_message(prefix,article)
      article.is_a?(ExceptionArticle) ? "\n#{article.to_s}" : "\n#{prefix}: #{article.to_s}"
    end

    def messages
      @messages ||= {exit_details: "\n\nExiting Details Screen...",
                      quit: "\nClosing down ArticleManager...\n",
                      greeting: "\nWelcome to ArticleManager!\n\n",
                      bad_command: "\n\nError: Unknown command. Enter '?' and press enter to see available commands\n\n",
                      help: "\n\nAvailable Commands for ArticleManager:\n\t[l]: List Articles \n\t[#]: List Details for Article # (# is the id for the article)\n\t\tCommands in the List Details Screen:\n\t\t\t[d]: Delete Article\n\t\t\t[u]: Update Article\n\t\t\t[e]: Exit from the List Details Screen\n\t([a]: Add Article)\n\t[i]: Import Articles\n\t([e]: Export Articles)\n\t[q]: Quit\n\t[h]/[?]: Help (This screen)\n\n\tTo enter a command: enter the corresponding character and press enter",
                      normal: "\n\n[l]: List [#]: Details [i]: Import [h]/[?]: Help [q]: Quit",
                      details: "\n\n[d]: Delete [u]: Update [e]: Exit [h]/[?]: Help [q]: Quit"}
    end

    def switch_to_details_screen
      @state = :details
    end

    def exit_from_details_screen
      @state = :normal
    end

    def valid_article?(article)
      article.is_a?(Article)
    end
  end
end

#ArticleManager
#  v start
#  v import
#   x read files
#  v list_articles
#  v details
#   v remove
#   x update
#   v exit
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