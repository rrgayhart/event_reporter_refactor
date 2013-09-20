require 'csv'
require 'pry'
require "./lib/help"
require "./lib/message"
require "./lib/file"

class EventReporter
  attr_accessor :file, :queue, :contents

  def welcome
    puts "Welcome to the Event Reporter"
    run
  end

  def run
    input = ""
    while input != "exit"
      puts ""
      printf "enter command"
      input = gets.chomp
      process_input(input)
    end
  end

  def process_input(input)
    input_array = input.downcase.split(" ")
    command = input_array[0]
    directive = input_array[1..-1]
    case command
      when "help" then Help.new(directive).help_router
      when "load" then Eventfile.new(directive).load_router
      when "queue" then queue_router(directive)
      when "find" then find_router(directive)
      else return Message.new.error
    end
  end



  def queue_router(input_array)
    return input_array
  end

  def find_router(input_array)
    return input_array
  end

#----------------OLD COMMAND LIST---------------------------

  def prompt
    return "End of method"
  #  print "> "
  #  input = gets.chomp.to_s
  #  process_input(input)
  end

  def one_command(command)
      if command == "load" 
        load_file(default_file)
      elsif command == "help"
        puts "Here is a list of each command available. Please type help and the command for more details." 
        command_list.each do |command, description|
          puts command
        end
      elsif "exit" then print "Goodbye!" "\n"
      else
        Message.new.error
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
          print Message.new.error
        end
      elsif command == "queue"
        if assertion == "clear"
          clear_queue
        elsif assertion == "print"
          print_queue
        else Message.new.error
        end
      else print Message.new.error
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

end


#e = EventReporter.new
#e.run
#e.process_input("find first_name alice")
#e.save_to("tester.csv")
#e.print_file("first_name")
#e.queue_count
