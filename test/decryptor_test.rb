require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/decryptor'

class DecryptorTest < Minitest::Test

  def test_message_can_be_accepted
    decrypt = Decryptor.new(".6f3p7pi.6biqxbyvx8")

    assert_equal ".6f3p7pi.6biqxbyvx8", decrypt.message
  end

  def test_message_can_be_split_into_single_characters
    decrypt = Decryptor.new(".biqxbyvx8")
    d = decrypt.split_message

    assert_equal [".", "b", "i", "q", "x", "b", "y", "v", "x", "8"], d
  end

  def test_cypher_can_be_passed_into_Encryptor_class
    decrypt = Decryptor.new(message)

    assert decrypt.rev_cypher
  end

  def test_converting_characters_to_nums_by_index
    decrypt = Decryptor.new("hi")

    assert_equal [31, 30], decrypt.decrypting_indexed_message
  end

  def test_that_empty_strings_and_punctuations_can_be_indexed
    decrypt = Decryptor.new(" , .    ")
    d = decrypt.decrypting_indexed_message

    assert_equal [2, 0, 2, 1, 2, 2, 2, 2], d
  end

  def test_message_can_be_parsed_in_arrays_of_four
    decrypt = Decryptor.new(".biqxbyvx8")
    d = decrypt.parsed_message

    assert_equal [[1, 37, 30, 22], [15, 37, 14, 17], [15, 4]], d
  end

  def test_to_verify_that_empty_strings_can_be_parsed_in_arrays
    decrypt = Decryptor.new("        ")
    d = decrypt.parsed_message

    assert_equal [[2, 2, 2, 2], [2, 2, 2, 2]], d
    end

  def test_parsed_array_can_be_flattened
    decrypt = Decryptor.new(".biqxbyvx8")
    d = decrypt.parsed_message.flatten

    assert_equal [1, 37, 30, 22, 15, 37, 14, 17, 15, 4], d
  end

  def test_cycle_method_for_a_small_array_of_offsets
    decrypt = Decryptor.new(".biqxbyvx8")
    d = decrypt.decycled_offsets

    assert_equal [18, 25, 36, 50, 18, 25, 36, 50, 18, 25, 36, 50], d
  end

  def test_rotate_offset_can_be_created_with_key_and_date_and_index
    decrypt = Decryptor.new(".biqxbyvx8")
    d = decrypt.creating_rotating_offsets

    assert_equal [19, 62, 66, 72, 33, 62, 50, 67, 33, 29], d
  end

  def test_message_encrypts
    decrypt = Decryptor.new("z3iw6wtz9 a")

    assert_equal "hello world", decrypt.decrypted
  end

  def test_anotheor_message_encrypts_with_known_end
    decrypt = Decryptor.new(".6bjq3koqx")

    assert_equal "the..end..", decrypt.decrypted
  end

end
