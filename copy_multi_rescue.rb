file1 = ARGV[0]
file2 = ARGV[1]
begin
  io = File.open(file1)
rescue Error::ENOENT, Error::EACCESS
  io = File.open(file2)
end
