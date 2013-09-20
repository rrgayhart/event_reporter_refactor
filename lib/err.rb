require 'csv'
require 'pry'

class EventReporter
  attr_accessor :file, :queue, :contents

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
      if command == "load" 
        load_file(default_file)
      elsif command == "help"
        puts "Here is a list of each command available. Please type help and the command for more details." 
        command_list.each do |command, description|
          puts command
        end
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
        if @file == nil
          load_file('event_attendees.csv')
        end
        three_command(command, assertion_array)
      elsif command == "help"
        if command_list.include? assertion[0..-1]
          puts "#{assertion}: #{command_list[assertion]}"
        else 
          print "error"
        end
      else print "error"
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
    @file = file.chomp
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
    print_file("last_name")
  end

  def print_file(attribute)
    attribute = attribute.to_sym
    clean = @queue
    if @queue == []
      print "Nothing found in the queue. Search yielded no results"
    else
    @queue.sort_by! {|row| row[attribute]}
    print "\t\tLAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE\n"
    num = 0
    clean.each do |row|
      num += 1
      print "#{num}\t#{row[:last_name]}\t#{row[:first_name]}\t#{row[:email_address]}\t#{row[:zipcode]}\t#{row[:city]}\t#{row[:state]}\t#{row[:street]}\t#{row[:homephone]}\n"
    end
  end
  end

  def queue
    @queue ||= []
  end

  def queue_count
    queue.count
    puts queue.count
    return queue.count
  end

  def clear_queue
    @queue = []
  end

  def save_to(file_name)
    queue = @queue
    if file_name.include? '.csv'
      puts "Saving to #{file_name}"
      CSV.open(file_name, "a") do |csv|
          csv << queue
        end
    else
      puts "A default_event_reporter0000.csv file will be generated for you, or updated if existing."
      CSV.open("default_event_reporter0000.csv", "wb") do |csv|
        csv << queue
      end
    end 
  end

  def attribute_list
    ["first_name", "last_name", "email_address", "zipcode", "city", "state", "street", "homephone"]
  end

  def list_attributes
    attribute_list.each do |a|
      print "'#{a}'"
    end
  end

  def command_list
    {"load" => "Loads a CSV file that can be searched", "queue count" => "Counts the records in the queue", "queue clear" => "Clears your queue", "queue print" => "Prints your queue", "queue save to" => "Saves your queue to the specified queue", "find" => "Finds records based on your specified search attributes.", "exit" => "Exits the programm."}
  end

end


e = EventReporter.new
#e.list_attributes
#e.process_input("find first_name alice")
#e.save_to("tester.csv")
#e.print_file("first_name")
#e.queue_count
