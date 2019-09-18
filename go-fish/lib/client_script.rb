require 'socket'

class GoFishClient
  s = TCPSocket.new 'localhost', 3336

  Thread.new do
    loop do
      puts s.gets
    end
  end

  loop do
    client_name = $stdin.gets.chomp
    s.puts("#{client_name}\n")
  end
  s.close
end