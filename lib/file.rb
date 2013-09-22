require 'csv'
require 'pry'

class Eventfile
  attr_accessor :file, :name
  attr_reader :input

  def default_file
    "./lib/event_attendees.csv".chomp
  end
###---- WILL NEED TO GET RID OF THE ./lib after testing!! --------

  def initialize(input)
    @input = input.join(" ")
    @name ||= default_file
    @file ||= []
  end


  def load_router
    unless @input == "" 
      @name = @input
    end
    load_file
###----------------Consider putting a rescue in here incase file does not exist----------#
  end

  def load_file
    @contents = CSV.read"#{name}", headers: true, header_converters: :symbol
    clean_file
  end

  def clean_file
    dirty = @contents
    @file = dirty.each do |row|
      clean_phone(row[:homephone])
      clean_zip(row[:zipcode])
    end
  end

  def clean_phone(row)
      row.gsub!(/[- .)()]/, "")
      if row.length > 10 then row = "0000000000"
      elsif row.length < 10 then row = "0000000000"
      end
  end

  def clean_zip(row)
    row.to_s.rjust(5,"0")[0..4]
  end

end
  
