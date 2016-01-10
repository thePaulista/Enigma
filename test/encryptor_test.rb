require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/encryptor'

class EncryptorTest < Minitest::Test

  def test_message_can_be_accepted
    encrypt = Encryptor.new("hi")

    assert_equal "hi", encrypt.message
  end

  def test_message_can_be_split_into_single_characters
    encrypt = Encryptor.new("hi")

    assert_equal ["h","i"], encrypt.split_message
  end

  def test_empty_strings_can_be_split_into_elements
    encrypt = Encryptor.new("         ")
    e = encrypt.split_message

    assert_equal [" ", " ", " ", " ", " ", " ", " ", " ", " "], e
  end

  def test_cypher_can_be_passed_into_Encryptor_class
    encrypt = Encryptor.new("hi")

    assert_equal Cypher.new.c_map, encrypt.cypher
  end

  def test_converting_characters_to_nums_by_index
    encrypt = Encryptor.new("hi")

    assert_equal [7,8], encrypt.indexed_message
  end

  def test_that_empty_strings_and_punctuations_can_be_indexed
    encrypt = Encryptor.new(" , .    ")
    e = encrypt.indexed_message

    assert_equal [36, 38, 36, 37, 36, 36, 36, 36], e
  end

  def test_message_can_be_parsed_in_arrays_of_four
    encrypt = Encryptor.new("hello world")
    e = encrypt.parsed_message

    assert_equal [[7, 4, 11, 11], [14, 36, 22, 14], [17, 11, 3]], e
  end

  def test_to_verify_that_empty_strings_can_be_parsed_in_arrays
    encrypt = Encryptor.new("        ")
    e = encrypt.parsed_message

    assert_equal [[36, 36, 36, 36], [36, 36, 36, 36]], e
    end

  def test_parsed_array_can_be_flattened
    encrypt = Encryptor.new("hello world")
    e = encrypt.parsed_message.flatten

    assert_equal [7, 4, 11, 11, 14, 36, 22, 14, 17, 11, 3], e
  end

  def test_cycle_method_for_a_small_array_of_offsets
    encrypt = Encryptor.new("hello world")
    e = encrypt.cycled_offsets

    assert_equal [18, 25, 36, 50, 18, 25, 36, 50, 18, 25, 36, 50], e
  end

  def test_rotate_offset_can_be_created_with_key_and_date_and_index
    encrypt = Encryptor.new("hello world")
    e = encrypt.creating_rotate_offset

    assert_equal [25, 29, 47, 61, 32, 61, 58, 64, 35, 36, 39], e
  end

  def test_rotate_offset_can_be_generated_with_empty_strings
    encrypt = Encryptor.new("     ")
    e = encrypt.creating_rotate_offset

    assert_equal [54, 61, 72, 86, 54], e
  end

  def test_message_encrypts
    encrypt = Encryptor.new("hello world")

    assert_equal "z3iw6wtz9 a", encrypt.encrypted
  end

  def test_anotheor_message_encrypts_with_known_end
    encrypt = Encryptor.new("the..end..")

    assert_equal ".6bjq3koqx", encrypt.encrypted
  end

end
