require 'csv'
require 'pry'

class Eventfile
  attr_accessor :file

  def default_file
    "./lib/event_attendees.csv".chomp
  end
###---- WILL NEED TO GET RID OF THE ./lib after testing!! --------

  def initialize(input)
    @input = input.join(" ")
    @file ||= default_file
  end


  def load_router
    unless @input == "" 
      @file = @input
    end
    load_file
###----------------Consider putting a rescue in here incase file does not exist----------#
  end

  def load_file
    @contents = CSV.read"#{file}", headers: true, header_converters: :symbol
    return @contents
    #clean_file
  end
#Next step is to add the clean_file methods and then correct the nameing on file/input/contents - reassign!
end
  
