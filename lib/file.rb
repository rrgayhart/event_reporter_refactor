require 'csv'
require 'pry'

class Eventfile
  attr_accessor :input

  def initialize(input)
    @input = input
  end

  def load_router
    directive = input.join(" ")
    if input == [] 
      return load
    else
      #if command_list.include? directive
      #  return "#{directive}: #{command_list[directive]}"
      #else
      #  Message.new.error
      #end
    end
  end

end
  
