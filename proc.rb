hello = Proc.new do |name|
  puts "ABC #{name}"
end

hello.call("Test")
hello.call("TEST")
