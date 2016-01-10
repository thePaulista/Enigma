require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/crack.rb'

class CrackTest < Minitest::Test

  def test_crack_test_can_be_initialized
    crack = Crack.new(message)

    assert crack
  end

  def test_can_take_an_encrypted_code
    crack = Crack.new("i7bork5xvq5fsaraxal")

    assert_equal "i7bork5xvq5fsaraxal", crack.message
  end

  def test_cypher_can_be_invoked_on_initialize
    crack = Crack.new(message)

    assert crack.key
  end

  def test_initializes_with_a_known_end
    crack = Crack.new(message)

    assert_equal "..end..", crack.dot_end
  end

  def test_message_can_be_split_and_downcased
    crack = Crack.new("HELLO")

    assert_equal ["h", "e", "l", "l", "o"], crack.split_message
  end

  def test_message_can_accounts_for_spaces_and_other_characters
    crack = Crack.new("YO!!# Wha??")

    assert_equal ["y", "o", "!", "!", "#", " ", "w", "h", "a", "?", "?"], crack.split_message
  end

  def test_that_the_encryption_can_be_indexed
    crack = Crack.new('fyxwd181dv')

    assert_equal [5, 24, 23, 22, 3, 27, 34, 27, 3, 21], crack.indexed_message
  end

  def test_that_encrypted_spaces_can_be_indexed
    crack = Crack.new('    ')

    assert_equal [36, 36, 36, 36], crack.indexed_message
  end

  def test_that_the_encrypted_index_can_be_reversed_and_arrayed_in_fours
    crack = Crack.new('fyxwd181dv')
    reverse = crack.reverse_indexed_message

    assert_equal [[21, 3, 27, 34], [27, 3, 22, 23], [24, 5]], reverse
  end

  def test_that_indexed_encryption_can_garner_last_four_indicis
    crack = Crack.new('fyxwd181dv')

    assert_equal [34, 27, 3, 21], crack.last_four_of_indexed_message
  end

  def test_that_last_of_dot_end_can_be_indexed
    crack = Crack.new(message)
    ndot = crack.last_four_index_the_dot_end

    assert_equal [13, 3, 37, 37], ndot
  end

  def test_that_two_arrays_of_four_can_be_zipped_together
    crack = Crack.new('fyxwd181dv')
    zipper = crack.zipping_both_last_fours

    assert_equal [[37, 21], [37, 3], [3, 27], [13, 34]], zipper
  end

  def test_that_the_zipped_indicis_yield_a_delta
    crack = Crack.new('fyxwd181dv')
    delta_d = crack.distance_between_the_last_fours

    assert_equal [16, 34, -24, -21], delta_d
  end

  def test_ndot_indicis_can_replicate_for_the_length_of_the_encryption
    crack = Crack.new('fyxwd181dv')
    a = crack.cycle_indicis

    assert_equal [16, 34, -24, -21, 16, 34, -24, -21, 16, 34, -24, -21], a
  end

  def test_the_reversed_encryption_can_be_zipped_with_ndot_replication
    crack = Crack.new('fyxwd181dv')
    b = crack.zip_prerotator_values

    assert_equal [[16, 21], [34, 3], [-24, 27], [-21, 34],
    [16, 27], [34, 3], [-24, 22], [-21, 23], [16, 24],
    [34, 5], [-24, nil], [-21, nil]], b
  end

  def test_that_arrays_with_nil_can_be_eliminated
    crack = Crack.new('fyxwd181dv')
    c = crack.nihilate_prerotator_value

    assert_equal [[16, 21], [34, 3], [-24, 27], [-21, 34],
     [16, 27], [34, 3], [-24, 22], [-21, 23], [16, 24], [34, 5]], c
  end

  def test_that_the_indicis_can_be_added_to_get_rotation_values
    crack = Crack.new('fyxwd181dv')
    d = crack.add_indicis_to_get_rotation_values

    assert_equal [37, 37, 3, 13, 43, 37, -2, 2, 40, 39], d
  end

  def test_that_encryption_can_be_cracked
    crack = Crack.new('fyxwd181dv')

    assert_equal "abc..end..", crack.cracked
  end

  def test_test_that_encryption_refute
    crack = Crack.new('i7bork5xvq5fsaraxal')

    refute_equal "abc..end..", crack.cracked
  end

  def test_test_that_encryption_can_be_cracked_again!
    crack = Crack.new('i7bork5xvq5fsaraxal')

    assert_equal "1511 is boss..end..", crack.cracked
  end
end
