#start the server
#create rooms
#assign clients to room

require_relative '../lib/game'
require 'socket'
require 'pry'

class GoFishServer
  attr_reader :rooms, :clients_in_lobby, :port_number, :ip_address, :server

  def initialize
    @rooms = Hash.new
    @clients_in_lobby = []
  end

  def port_number
    3336
  end
  
  def ip_address
    'localhost'
  end
  
  def start
    @server = TCPServer.new(ip_address, port_number)
  end

  def closed?
    @server.closed? unless @server.close
  end
  
  def accept_new_client(player_name = "Player")
    client = server.accept_nonblock
    client.puts "Welcome To The Go Fish Game Server"
    client.puts "Please Enter Your Name:"
    player = client.gets.chomp
    puts "Client connected"
    client.puts "You are connected to the server"
    clients_in_lobby.push(player)
    create_room_if_possible
  rescue IO::WaitReadable, Errno::EINTR
  end
  
  def stop
    rooms.each do |_game, connections|
      connections.each {|client| client.close}
    end
    @server.close if @server
  end

  def create_room_if_possible
    if clients_in_lobby.count == 3
      game = GoFishGame.new(clients_in_lobby)
      puts "Game of Go Fish created with #{clients_in_lobby.count} players!"
      game_setup(game)
    end
  end

  def game_setup(game)
    game.start
    game.deal_cards
  end

  def client_input
    puts "It is #{current_player.name}'s' turn"
    input = current_player.gets.chomp
    game.check_client_input(input)
  end

  def game_rounds
    game.play_game
  end
end