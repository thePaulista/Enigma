require_relative 'cypher'
require_relative 'engine'

class Encryptor
  attr_reader :message, :cypher

  def initialize(message)
    @message = message
    @cypher = Cypher.new.c_map
    @engine = Engine.new
  end

  def split_message
    @message = message.downcase
    return message.chars
  end

  def indexed_message
    elements = @cypher
    mssg = split_message
    return mssg.map {|d| elements.index(d)}
  end

  def parsed_message
    comb_value = indexed_message
    return indexed_message.each_slice(4).to_a {|a| p a}
  end

  def cycled_offsets
    offset = @engine.offset_sum
    p_message = parsed_message
    return complete_offset = offset.cycle(p_message.length).map {|x| x}
  end

  def creating_rotate_offset
    flattened_message = parsed_message.flatten
    flat_offsets = cycled_offsets
    rotate_offset = flattened_message.zip(flat_offsets).map {|x1, x2| x1.to_i + x2.to_i}
    return rotate_offset
  end

  def encrypted
    sum_for_rotator = creating_rotate_offset
    golden_eggs = []
    sum_for_rotator.each do |e|
      golden_eggs << @cypher.rotate(e)[0]
    end
    return golden_eggs.join("")
  end

end

e = Encryptor.new("the..end..")
print e.encrypted
