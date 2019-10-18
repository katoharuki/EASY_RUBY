module Module1
  Version = "1.0"

  def test1(name)
    puts "TEST #{name}"
  end

  module_function :test1
end

p Module1::Version
Module1.test1("Moduleのテスト")

include Module1
p Version
test1("includeのテスト")
