File.open("a.txt") do |i|
  i.each_line do |line|
    print line
  end
end
