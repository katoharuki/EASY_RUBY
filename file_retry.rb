file = ARGV[0]
begin
  io = File.open(file)
rescue
  sleep 3
  retry
end

data = io.read
io.close
