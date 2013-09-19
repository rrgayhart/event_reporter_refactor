require 'csv'
require 'pry'

class EventReporter
  
  def test
    input = gets.chomp
    process_input(input)
  end

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

  def default_file
    default = "event_attendees.csv"
    return default.chomp
  end
  
  def one_command(command)
    case command
      when "load" then load_file(default_file)
      else
        return "One command but not defined"
    end
  end

  def two_command(command, assertion_array)
      assertion = assertion_array.join(" ")
      if command == "load" 
        if assertion.include? ".csv"
          load_file(assertion)
        else
          load_file(default_file) 
        end
      else return "unrecognized"
      end
  end

  def three_command
  end
#-----------------------------------------------
#file section and etc
  def load_file(file)
    file_name = file.chomp
    @contents = CSV.read"#{file}", headers: true, header_converters: :symbol
    print_file
  end

  def clean_file(file)
  end

  def print_file
    contents = @contents
    print "ID\tLAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE\n"
    contents.each do |row|
      print "#{row[:id]}\t#{row[:last_name]}\t#{row[:first_name]}\t#{row[:email_address]}\t#{row[:zipcode]}\t#{row[:city]}\t#{row[:state]}\t#{row[:street]}\t#{row[:homephone]}\n"
    end
  end
end


e = EventReporter.new
e.load_file('event_attendees.csv')
