require "csv"

code = ARGV[0]
start_time = Time.now

# Shift_JISをUTF-8に変換
CSV.open("KEN_ALL.CSV","r:Shift_JIS:UTF-8") do |csv|
  csv.each do |record|
    # 郵便番号が引数の指定と一致したらそのレコードを表示
    puts record.join(" ") if record[2] == code
  end
end
p Time.now - start_time
