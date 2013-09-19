require 'minitest'
require 'minitest/autorun'
require './lib/err'

class ERRTest < MiniTest::Test
  def setup
  @event = EventReporter.new
  # @list = Array.new
  end

  def test_run_should_work
    response = @event.run("hello")
    assert_equal "hello", response
  end

  #def test_find_last_name_should_work
  # skip
  # input = 'find'.chomp
  # response = @event.process_input(input)
  # assert_equal "Boo", response
  #end

end
