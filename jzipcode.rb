require 'sqlite3'
require "csv"

class JZipCode
  CSV_COLUMN = {code: 2, pref: 6, city: 7, addr: 8}

#1.インスタンス変数にファイル名を保存
  def initialize(dbfile)
    @dbfile = dbfile
  end
#2.JZipCode#createがテーブルを作成し、KEN_ALL.CSVのデータをデータベースに登録するメソッド
  def create(zipfile)
#3.ファイルが存在している場合、何もしない
# ファイルが存在しない場合、
# SQLite3::Database#openメソッドを使い、新規にデータベースファイルを開き、
# SQLのCREATE TABLE分を発行する。
    return if File.exist?(@dbfile)
    SQLite3::Database.open(@dbfile) do |db| 
     db.execute(<<-SQL)
        CREATE TABLE IF NOT EXISTS zip_codes
          (code TEXT, pref TEXT, city TEXT, addr TEXT, alladdr TEXT)
      SQL
#5.処理をひとまとまりにするための記述
      db.execute("BEGIN TRANSACTION")

      CSV.open(zipfile, "r:Shift_JIS:UTF-8") do |csv|
        csv.each do |rec|
#6.ハッシュの作成
# ハッシュは、:code,:pref,:addr,alladdrをキーとして持つ。
# 抽出したデータをINSERT分で登録する。
          data = Hash.new
          CSV_COLUMN.each{|key, index| data[key] = rec[index] }
          data[:alladdr] = data[:pref] + data[:city] + data[:addr]
          db.execute(<<-SQL, data)
            INSERT INTO zip_codes VALUES
              (:code, :pref, :city, :addr, :alladdr)
          SQL
        end
      end
      db.execute("COMMIT TRANSACTION")
    end
    return true
  end

  def find_by_code(code)
    ret = []
    SQLite3::Database.open(@dbfile) do |db|
      db.execute(<<-SQL, code){|row| ret << row.join(" ") }
        SELECT code, alladdr
          FROM zip_codes
         WHERE code = ?
      SQL
    end
    return ret.map{|line| line + "\n"}.join  
  end

  def find_by_address(addr)
    ret = []
    SQLite3::Database.open(@dbfile) do |db|
      like = "%#{addr}%"
      db.execute(<<-SQL, like){|row| ret << row.join(" ") }
        SELECT code, alladdr
          FROM zip_codes
         WHERE alladdr LIKE ?
      SQL
    end
    return ret.map{|line| line + "\n"}.join  
  end
end
