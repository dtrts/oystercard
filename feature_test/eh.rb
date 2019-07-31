class Exposure
  def arr
    @arr.dup
  end

  def initialize
    @arr = [1, 2, 3, [5, 6, 7]]
  end
end

e = Exposure.new
puts e.arr

e.arr[0] = 'asd'

puts e.arr
