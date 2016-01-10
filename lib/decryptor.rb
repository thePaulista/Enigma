require_relative 'cypher'
require_relative 'engine'

class Decryptor
  attr_reader :message, :rev_cypher, :key

  def initialize(message, key=12345)
    @message = message
    @rev_cypher = Cypher.new.c_map.reverse
    @engine = Engine.new
    @key = key
  end

  def key_split
    @engine.key_gen
  end

  def split_message
    @message = message.downcase
    return message.chars
  end

  def decrypting_indexed_message
    elements = @rev_cypher
    mssg = split_message
    return mssg.map {|d| elements.index(d)}
  end

  def parsed_message
    mssg = decrypting_indexed_message
    return mssg.each_slice(4).to_a {|a| p a}
  end

  def key_plus_date_array
    offs = @engine.date_assignment
    keys = key_split
    comb_array = keys.zip(offs)
    a = comb_array[0]
    b = comb_array[1]
    c = comb_array[2]
    d = comb_array[3]
    return step_one = [a,b,c,d]
  end

  def decrypting_offsets
    dcrypt = key_plus_date_array
    a1 = dcrypt[0]
    b1 = dcrypt[1]
    c1 = dcrypt[2]
    d1 = dcrypt[3]

    a = a1[0].to_i + a1[1].to_i
    b = b1[0].to_i + b1[1].to_i
    c = c1[0].to_i + c1[1].to_i
    d = d1[0].to_i + d1[1].to_i

    return dcrypt_offsets = [a,b,c,d]
  end

  def decycled_offsets
    d_offset = decrypting_offsets
    d_message = decrypting_indexed_message
    complete_offset = d_offset.cycle(parsed_message.length).map {|x| x}
  end

  def creating_rotating_offsets
    flat_offsets = decycled_offsets
    return decrypting_indexed_message.zip(flat_offsets).map {|x1, x2| x1.to_i + x2.to_i}
  end

  def decrypted
    sum_for_rotator = creating_rotating_offsets
    golden_eggs = []
    sum_for_rotator.each do |e|
      golden_eggs << @rev_cypher.rotate(e)[0]
    end
    return golden_eggs.join("")
  end

end
d = Decryptor.new(".biqxbyvx8", 12345)
# puts decrypt.key_split
# p d.split_message
# p d.decrypted
# p d.decrypting_offsets
p d.parsed_message
# p d.decycled_offsets
