require 'minitest'
require 'minitest/autorun'
require 'csv'
require './lib/err'

class ERRTest < MiniTest::Test
  def setup
  @event = EventReporter.new
  #@file = ('file','sample')
  @blank_array = Array.new
  end

  def test_it_should_divide_one_command
    response = @event.run("hello")
    assert_equal "One command but not defined", response
  end

  def test_load_should_load_specific_file
    input = "load test.csv"
    response = @event.run(input)
    assert_equal "test.csv", response
  end

  def test_load_without_csv_loads_default_file
    response = @event.run("load not real file")
    assert_equal "event_attendees.csv", response
  end

  def test_load_by_itself_should_load_default_file
    input = "load"
    response = @event.run(input)
    assert_equal "event_attendees.csv", response
  end

  def test_it_should_divide_make_two_command
    input = "foo bar"
    response = @event.run(input)
    assert_equal "unrecognized", response
  end

  #def test_load_file_should_respond
  #  test_file = EventFile("event_attendees.csv")
  #  response = test_file.load_file("event_attendees.csv")
    #assert_equal "event_attendees.csv" response
  #end


  #def test_find_last_name_should_work
  # skip
  # input = 'find'.chomp
  # response = @event.process_input(input)
  # assert_equal "Boo", response
  #end

end
