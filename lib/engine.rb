class Engine
  attr_reader :date, :offset, :key

  def initialize
    @date = Time.new
    @key = 12345
  end

  def five_rand
    num = [*0..9]
    return num.sample(5)
  end

  def key_gen
    five_num = @key.to_s
    a = five_num[0..1]
    b = five_num[1..2]
    c = five_num[2..3]
    d = five_num[3..4]
    return final_key_gen = [a,b,c,d]
  end

  def date_squared
    formatted_date = @date.strftime("%d%m%y").to_i
    squared_date = (formatted_date ** 2).to_s
    return squared_date[-4..-1].to_s
  end

  def date_assignment
    @offset = date_squared
    a = @offset[0]
    b = @offset[1]
    c = @offset[2]
    d = @offset[3]
    return date_offset = [a,b,c,d]
  end

  def combo_offset_array
    gen = key_gen
    date = date_assignment
    comb_array = gen.zip(date)
    a = comb_array[0]
    b = comb_array[1]
    c = comb_array[2]
    d = comb_array[3]
    return offset_array = [a,b,c,d]
  end

  def offset_sum
    offsum = combo_offset_array
    a1 = offsum[0]
    b1 = offsum[1]
    c1 = offsum[2]
    d1 = offsum[3]

    a = a1[0].to_i + a1[1].to_i
    b = b1[0].to_i + b1[1].to_i
    c = c1[0].to_i + c1[1].to_i
    d = d1[0].to_i + d1[1].to_i

    return four_offsets = [a,b,c,d]
  end

end
