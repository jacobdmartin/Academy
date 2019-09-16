#gets input from person
require 'socket'

s = TCPSocket.new 'localhost', 3336
s.puts "Game of Go Fish Created"

Thread.new do
  loop do
    puts s.gets
  end
end

loop do
  msg = $stdin.gets.chomp
  s.puts("Play\n")
end

s.close