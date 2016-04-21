require_relative '../model/item'
require_relative '../model/todo_list'
require_relative '../view/list_viewer'

class ListManager
  attr_reader :todo_list
  include ListViewer

  def initialize
    @todo_list = TodoList.new
    ARGV.empty? ? interface : review_requests(ARGV)
  end

  def review_requests(command_array)
    commands = {"display" => :print_list, "add" => :add, "delete" => :delete,
      "check off" => :check_off, "check off all" => :check_off_all,
      "uncheck all" => :uncheck_all,
      "clear" => :clear_all, "add multiple" => :add_multiple}

    if commands[command_array[0]]
      if command_array[0] != "display"
        @todo_list.send(commands[command_array[0]], command_array[1])
      end
      print_list
    else
      request_unavailable(command_array[0])
    end
  end

  def interface
    greet
    print_list
    while true
      show_commands
      command = get_command.strip
      break if command == "quit"
      command = "display" if command.empty?

      if command == "add multiple"
        argument = educate_on_multiple
      elsif ["add", "delete", "check off"].include?(command)
        argument = get_argument(command)
      end

      command_array = [command, argument].compact
      review_requests(command_array)
      onwards = offer_to_quit
      break if onwards.include?("n")
    end

    choice = offer_to_print_list
    if choice.include?("y")
      second_choice = decide_checked_or_unchecked
      second_choice.include?("unchecked") ? @todo_list.export_unchecked_to_txt : @todo_list.export_all_to_txt
      notify_of_created_txt
    end

    say_goodbye
  end
end
