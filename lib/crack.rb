require_relative 'cypher'
require 'pry'

class Crack
  attr_reader :message, :key, :dot_end

  def initialize(message)
    @message = message
    @key = Cypher.new.c_map
    @dot_end = "..end.."
  end

  def split_message
    @message = message.downcase
    return message.chars
  end

  def indexed_message
    elements = @key
    mssg = split_message
    return mssg.map {|d| elements.index(d)}
  end

  def last_four_of_indexed_message
    first_four = indexed_message[-4..-1]
  end

  def reverse_indexed_message
    rev_idx_mssg = indexed_message.reverse
    rev_idx_mssg.each_slice(4).to_a {|a| p a}
  end

  def last_four_index_the_dot_end
    ndot = @dot_end.chars
    indexed_end = ndot.map {|k| @key.index(k)}
    last_four = indexed_end[-4..-1]
  end

  def zipping_both_last_fours
    a = last_four_index_the_dot_end.reverse
    b = last_four_of_indexed_message.reverse
    return a.zip(b)
  end

  def distance_between_the_last_fours
    combo_fours = zipping_both_last_fours
    distance_fours = []
    combo_fours.each do |a|
      distance_fours << a[0].to_i - a[1].to_i
    end
    return distance_fours
  end

  def cycle_indicis
    delta_d = distance_between_the_last_fours
    rev_mssg = reverse_indexed_message
    delta_d.cycle(rev_mssg.length).map {|i| i}
  end

  def zip_prerotator_values
   flat_mssg = reverse_indexed_message.flatten
   cycled_idx = cycle_indicis
   cycled_idx.zip(flat_mssg)
  end

  def nihilate_prerotator_value
    nihilate = zip_prerotator_values
    nihilate.reject {|n| n[1] == nil}
  end

  def add_indicis_to_get_rotation_values
    c_prerotator = nihilate_prerotator_value
    distance_btn_index = []
    c_prerotator.each do |a|
      distance_btn_index << a[0].to_i + a[1].to_i
    end
    return distance_btn_index
  end

  def cracked
    cypher = @key
    rotator_value = add_indicis_to_get_rotation_values
    cracked_mssg = []
    rotator_value.each do |crack|
      cracked_mssg << cypher.rotate(crack)[0]
    end
    return cracked_mssg.reverse.join("")
  end
end

crack = Crack.new(".6f3p7pi.6biqxbyvx8")
print crack.cracked
