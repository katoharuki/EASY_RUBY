sum = 0
outcome = {"チケット"=>3500, "チェキ"=>1000, "握手会"=>3000}
outcome.each do |i|
  sum += i[1]
end
puts "合計：#{sum}円"
