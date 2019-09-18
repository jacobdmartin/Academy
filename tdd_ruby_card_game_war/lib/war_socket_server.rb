require_relative 'war_game'
require_relative 'card_deck'
require_relative 'war_player'
require 'socket'

class WarSocketServer
  attr_reader :connected_clients, :connected_games, :games, :pending_clients, :server

  def initialize
    @connected_clients = Hash.new
    @connected_games = Hash.new
    @games = []
    @pending_clients = []
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

  def accept_new_client(player_name = "Random Player")
    client = server.accept_nonblock
    puts "Client connected"
    pending_clients.push(client)
  rescue IO::WaitReadable, Errno::EINTR
  end

  def create_game
    game1 = WarGame.new
    game1.start
    connected_games[game1] = pending_clients.shift(2)
    puts "Game of War Created!"
    game1
  end

  def create_game_if_possible
    if pending_clients.count == 2
      create_game
    end
  end

  def stop
    connected_games.each do |_game, connections|
      connections.each {|client| client.close}
    end
    @server.close if @server
  end

  def run
    while(@server) do
      accept_new_client
      game = create_game_if_possible
      if game
        run_game(game)
      end
    end
  end

  def ready_message(game)
    clients = connected_games[game]
    clients.each do |client|
      client.puts "If you are ready press enter to Play"
    end
  end

  def run_game(game)
    Thread.new do
      ready_message(game)
      game_clients = connected_games[game]
      loop do
        player1_status = game_clients[0].gets.chomp
        player2_status = game_clients[1].gets.chomp
        if player1_status == "Play" && player2_status == "Play"
          message = game.play_round
        end
        game_clients.each do |client|
          client.puts message
        end
        if game.winner
          game.winner.puts "You Won"
        end
      end
    end
  end
end
