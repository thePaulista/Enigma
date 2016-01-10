require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/engine'

class EngineTest < Minitest::Test

  def test_the_class_can_be_initialized
    engine = Engine.new

    assert engine
  end

  def test_time_is_initialized
    engine = Engine.new

    assert engine.date
  end

  def test_that_the_test_key_is_12345
      engine = Engine.new

    assert_equal 12345, engine.key
  end

  def test_five_rand_outputs_can_be_generated
    engine = Engine.new

    assert_equal 5, engine.five_rand.length
  end

  def test_key_can_be_indexed_into_two_digit_array
    engine = Engine.new
    e = engine.key_gen

    assert_equal ["12", "23", "34", "45"], e
  end

  def test_date_is_formatted_as_ddmmyy
    engine = Engine.new
    e = engine.date.strftime("%d%m%y").to_i

    assert_equal 171215, e
  end

  def test_date_squared_yields_last_four_digits
    engine = Engine.new

    assert_equal "6225", engine.date_squared
  end

  def test_date_squared_can_be_stringed_in_array
    engine = Engine.new

    assert_equal ["6", "2", "2", "5"], engine.date_assignment
  end

  def test_offset_values_can_be_zipped
    engine = Engine.new
    e = engine.combo_offset_array

    assert_equal [["12", "6"], ["23", "2"], ["34", "2"], ["45", "5"]], e
  end

  def test_it_returns_the_offset_summed_in_an_array_of_four
    engine = Engine.new
    e = engine.offset_sum

    assert_equal [18, 25, 36, 50], e
  end

end
