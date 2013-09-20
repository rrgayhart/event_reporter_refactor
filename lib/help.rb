require 'csv'
require 'pry'

class Help
    attr_accessor :input

  def initialize(input)
    @input = input
  end

  def help_router
    directive = input.join(" ")
    if input == [] 
      list_commands
    else
      help_specific(directive)
    end
  end

  def help_specific(directive)
    if command_list.include? directive
        return "#{directive}: #{command_list[directive]}"
    else
        Message.new.error
    end
  end

  def list_commands
    return "Here is a list of each command available. Please type help and the command for more details." 
    command_list.each do |command, description|
      return command
    end
  end

  def command_list
    {"load" => "Loads a CSV file that can be searched", "queue count" => "Counts the records in the queue", "queue clear" => "Clears your queue", "queue print" => "Prints your queue", "queue save to" => "Saves your queue to the specified queue", "find" => "Finds records based on your specified search attributes.", "exit" => "Exits the programm."}
  end

end
