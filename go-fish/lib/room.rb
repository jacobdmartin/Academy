#start game
#-with clients ready
#talk to players clients
#talk to game

require_relative '../lib/player'
require_relative  '../lib/game'
require_relative '../lib/room_player'

class GameRoom
  
  def initialize(clients_from_lobby)
    @room_players = RoomPlayer.new(clients_from_lobby)
  end

  def run
    Thread.new do
      loop do

      end
    end
  end

  def start_game
    game = GoFishGame.new
    game.start
    connected_games[game] = pending_clients.shift(2)
    puts "Game of War Created!"
    game
  end
  
  def create_game_if_possible
    if pending_clients.count == 2
      create_game
    end
  end

  # def process_input(room_player, message)
  #   room_player.player == @game.current_player
  # end

  # def take_turn(player)
  #   inquire_for_card()
  # end

  # def ready_message(game)
  #   clients = connected_games[game]
  #   clients.each do |client|
  #     client.puts "If you are ready press enter to Play"
  #   end
  # end

  # def run_game(game)
  #   Thread.new do
  #     ready_message(game)
  #     game_clients = connected_games[game]
  #     loop do
  #       player1_status = game_clients[0].gets.chomp
  #       player2_status = game_clients[1].gets.chomp
  #       if player1_status == "Play" && player2_status == "Play"
  #         message = game.play_round
  #       end
  #       game_clients.each do |client|
  #         client.puts message
  #       end
  #       if game.winner
  #         game.winner.puts "You Won"
  #       end
  #     end
  #   end
  # end
end