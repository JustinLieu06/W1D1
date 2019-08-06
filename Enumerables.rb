class Array
  def my_each(&block)
    (0...self.length).each do |i|
      block.call(self[i])
    end
    return self
  end

  def my_select(&block)
    arr = []
    self.my_each do |ele|
        arr << ele if block.call(ele)
    end
    arr
  end

  def my_reject(&block)
    arr = []
    self.my_each do |ele|
        arr << ele if !block.call(ele)
    end
    arr
  end
  
  def my_any?(&block)
    self.my_each do |ele|
        return true if block.call(ele)
    end
    false
  end

  def my_all?(&block)
    self.my_each do |ele|
        return false if !block.call(ele)
    end
    true
  end

  def my_flatten
    my_real_flatten(self)
  end

  def my_real_flatten(item)
    if item.is_a?(Array)
      if item.length >= 2
        return my_real_flatten(item[0]) + my_real_flatten(item[1..-1])
      else 
        return my_real_flatten(item[0])
      end
    end 
    [item]
  end

  def my_zip(*ele)
    result = []
    self.each do |ele|
        result << [ele]
    end
    (0...result.length).each do |i|
        ele.each do |e|
            result[i] << e[i]
        end
    end
    result
  end

  def my_rotate(value=1)
    #value %= self.length
    arr = Array.new(self.length, 0)
    self.each_with_index do |ele, idx|
      i = (idx+value) % self.length
      #arr[(idx+value)%self.length] = ele
      arr[idx] = self[i]
    end
    arr
  end

  def my_join(sep = "")
    str = ""
    self.each do |ele|
        str += ele + sep
    end
    if sep == ""
        return str
    else
        return str[0...-1] 
    end
  end

  def my_reverse
    arr = []
    self.each_with_index do |ele, idx|
        i = self.length - 1 - idx
        arr << self[i]
    end
    arr
  end
end

# return_value = [1, 2, 3].my_each do |num|
#     puts num
#   end.my_each do |num|
#     puts num
#   end

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]