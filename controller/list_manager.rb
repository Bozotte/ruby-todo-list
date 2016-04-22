require_relative '../model/item'
require_relative '../model/todo_list'
require_relative '../view/list_viewer'
require 'colorize'

class ListManager
  attr_reader :todo_list
  include ListViewer

  def initialize
    @todo_list = TodoList.new
    ARGV.empty? ? interface : review_requests(ARGV)
  end

  def review_requests(command_array)
    list_commands = ["add", "add_multiple", "delete", "delete_all", "check_off", "check_off_all", "uncheck_all", "tag", "untag"]
    view_commands = ["display", "display_by_tag", "show_completed", "show_uncompleted"]

    if command_array[0]
      if list_commands.include?(command_array[0])
        @todo_list.send(command_array[0], command_array[1])
        display(@todo_list.list)
      elsif view_commands.include?(command_array[0])
        self.send(command_array[0], command_array[1])
      end

    else
      request_unavailable(command_array[0])
    end
  end

  def interface
    greet
    display(@todo_list.list)
    while true
      show_commands
      command = get_command.strip
      break if command == "quit"
      if command.empty? || command == "display"
        command = "display"
        argument = @todo_list.list
      end

      if command == "add multiple"
        argument = educate_on_multiple
      elsif ["add", "delete", "check off"].include?(command)
        argument = get_argument(command)
      elsif ["tag", "untag"].include?(command)
        argument = get_argument(command)
        tag = tag_as_personal_or_code(command)
        argument = [argument, tag].compact
      elsif command == "display by tag"
        argument = ask_for_tag_to_display
      end

      command = command.split.join("_")
      command_array = [command, argument].compact
      review_requests(command_array)
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
