require 'csv'
require 'pry'
require './lib/file'

class EventReporter

  def run(input)
    @input = input.chomp
    process_input(@input)
  end

  def process_input(input)
    input_array = input.split(" ")
    command = input_array[0]
    assertion_array = input_array[1..-1]
    case assertion_array
      when [] then one_command(command)
      else two_command(command, assertion_array)
    end
  end
  
  def one_command(command)
    case command
      when "load" then return "#{command}"
      else
        return "One command but not defined"
    end
  end

  def two_command(command, assertion_array)
      assertion = assertion_array.join(" ")
      if command == "load" 
        if assertion.include? ".csv"
          return "detected"
        else
          return "#{assertion}"
        end
      else return "unrecognized"
      end
  end

  def three_command
  end


end
