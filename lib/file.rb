require 'csv'
require 'pry'
require './lib/err'

class EventFile
  
  def initialize(name)
    @name = name
    load_file(name)
  end

  def load_file(name)
    return "#{name}"
  end

end

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
