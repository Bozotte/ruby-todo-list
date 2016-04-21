module ListViewer
  def print_list
    puts "\nYour todo list:\n\n"
    todo_list.list.each do |item|
      checked = item.checked ? item.checked : " "
      puts "[ #{checked} ] #{item.item}"
    end
    puts
  end

  def request_unavailable(request)
    puts "Your request: #{request}\nThis is not available."
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
    puts "   check off, check off all,"
    puts " uncheck all, delete, delete all"
    puts "             quit               \n\n"
    puts "-------------------------------"
  end

  def educate_on_multiple
    puts "\nEnter items like so: walk the cat, eat food, shower"
    print "Items to add:   "
    input.split(", ")
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
