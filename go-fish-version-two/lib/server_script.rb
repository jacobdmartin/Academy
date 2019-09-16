require_relative '../lib/game'

server = GoFishServer.new
server.start

loop do
  server.accept_new_client
  sleep(1)
end

#blocking connect
