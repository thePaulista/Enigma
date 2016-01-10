class Cypher
  attr_reader :c_map

  def initialize
    @c_map = [*"a".."z", *"0".."9", " ", ".", ","]
  end

end
