module Extend
  def extend(x)
    "#{self} #{x}"
  end
end

str = "TEST"
str.extend(Extend)

p str.extend(5)
