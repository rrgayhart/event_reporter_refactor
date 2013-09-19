require 'csv'
require 'pry'

class EventReporter

  def run(input)
    @input = input.chomp
    return @input
  end

  def process_input(input)

  end
  
  def load(file_input)
    if file_input == ""
    file = default_file
    else file = file_input
    end
    @file = file
    puts "You have now opened: #{file}"
    @contents = CSV.read "#{file}", headers: true, header_converters: :symbol
    #print_template
  end

end
