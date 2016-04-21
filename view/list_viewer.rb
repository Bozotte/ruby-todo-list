module ListViewer
  def display(list)
    puts
    list.each do |item|
      checked = item.checked ? item.checked.colorize(:green) : " "
      tags = ""
      tags << "[#{item.personal}]".colorize(:yellow) if item.personal
      tags << "[#{item.code}]".colorize(:light_blue) if item.code
      puts "[#{checked}] #{item.item} #{tags}"
    end
    puts
  end

  def ask_for_tag_to_display
    print "Display items tagged with what tag?   "
    input
  end

  def display_by_tag(tag)
    list = todo_list.list.select{|item| item.send(tag) != nil }
    puts "\n#{tag.capitalize}:"
    display(list)
  end

  def show_completed
    list = todo_list.list.select{|item| item.checked }
    puts "\nCompleted:"
    display(list)
  end

  def show_uncompleted
    list = todo_list.list.select{|item| item.checked.nil? }
    puts "\nUnfinished:"
    display(list)
  end

  def request_unavailable(request)
    puts "Your request: #{request}\nThis is not available.\n\n"
  end

  def greet
    puts "-------------------------------"
    puts "  Welcome to your todo list!\n\n"
    puts "    This list alters itself "
    puts "      one item at a time. "
  end

  def show_commands
    puts "-------------------------------"
    puts "     Available commands: \n\n"
    puts "  display, add, add multiple, "
    puts "  tag, untag, display by tag,"
    puts "   check off, check off all,"
    puts " uncheck all, delete, delete all,"
    puts " show completed, show uncompleted,"
    puts "             quit               \n\n"
    puts "-------------------------------"
  end

  def educate_on_multiple
    puts "\nEnter items like so: walk the cat, eat food, shower"
    print "Items to add:   "
    input.split(", ")
  end

  def tag_as_personal_or_code(tag)
    print "#{tag.capitalize} personal or code?  "
    input
  end

  def get_command
    print "Enter command:   "
    input
  end

  def get_argument(command)
    print "#{command.capitalize} what?  "
    input
  end

  def offer_to_quit
    print "Continue? (y/n)   "
    input
  end

  def offer_to_print_list
    print "Would you like to print your list? (y/n)   "
    input
  end

  def decide_checked_or_unchecked
    print "Would you like all the items in your list, or just the unchecked ones? (all/unchecked)  "
    input
  end

  def notify_of_created_txt
    puts "\nYour file is called 'todays_list.txt'. "
  end

  def say_goodbye
    puts "\nThanks for using your todo list and being productive :) \n\n"
  end

  def input
    gets.chomp
  end
end
