require 'csv'
require 'pry'

class EventFile
  
  def initialize(file, name)
    @file = file
    @name
  end

  def read_file
    print @file
  end
end

def read_name
  print @name
end

m=EventFile.new("noo", "ber")
m.read_file
m.read_name


  #def load(file_input)
  #  if file_input == ""
  #  file = default_file
  #  else file = file_input
  #  end
  #  @file = file
  #  puts "You have now opened: #{file}"
  #  @contents = CSV.read "#{file}", headers: true, header_converters: :symbol
    #print_template
  #end
