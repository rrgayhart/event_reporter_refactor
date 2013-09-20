require 'csv'
require 'pry'

class EventReporter

  def is_file?
    @is_file = []
  end
  
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
  
  def one_command(command)
    case command
      when "load" then load_file(default_file)
      else
        puts "One command but not defined"
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
      elsif command == "find"
        load_file('event_attendees.csv')
        three_command(command, assertion_array)
      else puts assertion_array[2]
      end
  end

  def three_command(command, assertion)
    if command == "find"
      attribute = assertion[0]
      criteria = assertion[1..-1].join(" ")
      find_by(attribute, criteria)
    end
  end

#-----------------------------------------------
#file section and etc

  def default_file
    default = "event_attendees.csv"
    return default.chomp
  end

  def load_file(file)
    @file_name = file.chomp
    @contents = CSV.read"#{file}", headers: true, header_converters: :symbol
    clean_file
  end

  def clean_file
    dirty = @contents
    @clean = dirty.each do |row|
      row[:homephone].gsub!(/[- .)()]/, "")
      if row[:homephone].length > 10 then row[:homephone] = "0000000000"
      elsif row[:homephone].length < 10 then row[:homephone] = "0000000000"
      end
      row[:zipcode].to_s.rjust(5,"0")[0..4]
    end
  end

  def find_by(attribute, query)
    attribute = attribute.to_sym
    searchable = @clean
    @queue = []
    searchable.each do |row|
      if row[attribute] == nil
        row[attribute] = ""
      elsif query.upcase == row[attribute].upcase
        @queue << row
      end
    end
    print_file
  end

  def print_file
    clean = @queue
    print "\t\tLAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE\n"
    num = 0
    clean.each do |row|
      num += 1
      print "#{num}\t#{row[:last_name]}\t#{row[:first_name]}\t#{row[:email_address]}\t#{row[:zipcode]}\t#{row[:city]}\t#{row[:state]}\t#{row[:street]}\t#{row[:homephone]}\n"
    end
  end
end


e = EventReporter.new
e.load_file('event_attendees.csv')
e.process_input("find homephone 000000000")
