class Point
  attr_accessor :x, :y

  def initialize(x=0, y=0)
    @x, @y = x, y
  end

  def inspect
    "(#{x}, #{y})"
  end

  def +(other)
    self.class.new(x + other.x, y + other.y)
  end

  def -(other)
    self.class.new(x - other.x, y - other.y)
  end

  def ~@
    self.class.new(-y, x)
  end
end

point0 = Point.new(1, 2)
point1 = Point.new(3, 4)

p point0
p point1

p point0 + point1
p point0 - point1
p point1 - point0

p ~point1
