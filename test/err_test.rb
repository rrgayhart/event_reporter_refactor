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

  def test_help_by_itself_should_list_commands
    response = @event.process_input('Help')
    assert_includes response, "Here"
  end

  def test_help_and_command_should_list_details
    response = @event.process_input('Help find')
    assert_includes response, "find" 
  end

  def test_error_message_command_works
    response = @event.process_input('Help wonderwall')
    assert_includes response, "recognize"
  end

  def test_error_message_command_still_works
    response = @event.process_input('wonderwall')
    assert_includes response, "recognize"
  end  

  def test_queue_should_be_recognized
    response = @event.process_input('queue')
    assert_equal [], response
  end

  def test_default_file_should_be_recognized
    response = @event.process_input('load')
    assert_includes response.to_s, "SAUNDERS"
  end

  def test_csv_file_should_be_loaded
    response = @event.process_input('load ./lib/test.csv')
    assert_includes response.to_s, "\n"
  end

  def test_find_should_be_recognized
    response = @event.process_input('find')
    assert_equal [], response
  end


  #------------OLD TESTS LINE ---------------#

  def test_it_should_divide_one_command
    skip
    response = @event.run("hello")
    assert_equal "One command but not defined", response
  end

  def test_load_should_load_specific_file
    skip
    input = "load test.csv"
    response = @event.run(input)
    assert_equal "test.csv", response
  end

  def test_load_without_csv_loads_default_file
    skip
    response = @event.run("load not real file")
    assert_equal "event_attendees.csv", response
  end

  def test_load_by_itself_should_load_default_file
    skip
    input = "load"
    response = @event.run(input)
    assert_equal "event_attendees.csv", response
  end

  def test_it_should_divide_make_two_command
    skip
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
