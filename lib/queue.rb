require 'csv'
require 'pry'

class Queue
  attr_accessor :queue

  def initialize(input)
    @input = input
    @queue ||= []
  end

  def queue_count
    queue.count
    return queue.count
  end

  def clear_queue
    @queue = []
  end

end
