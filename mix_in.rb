module A
  def test
    p "test"
  end
end

class B
  include A
end

b = B.new
b.test

p B.ancestors
p B.superclass
