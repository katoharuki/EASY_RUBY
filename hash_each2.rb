sum = 0
outcome = {"チケット"=>3500, "チェキ"=>1000, "握手会"=>3000}
outcome.each do |item,price|
  sum += price
end
puts "合計：#{sum}円"
