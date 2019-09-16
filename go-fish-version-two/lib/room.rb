#start game
#-with clients ready
#talk to players clients
#talk to game

require_relative '../lib/player'
require_relative  '../lib/game'
require_relative '../lib/room_player'
require_relative '../lib/server'
require 'pry'

class GameRoom
  attr_accessor :room_players
  
  def initialize(room_player)
    @room_players = []
  end
  
  def players_ready
    room_players.each do |room_player|
      room_player.puts "If you are ready press Enter"
    end
  end

  def start_game
    game = GoFishGame.new
    puts "a new game has been created"
    game.start
    puts "a new game has been started"
    game
  end

  def run
    puts "inside room.run"
    game = start_game
    assign_players_to_room_players(game)
  end

  def assign_players_to_room_players(game)
    game.players.each do |player|
      room_players.each do |room_player|
        room_player.player = player if room_player.name == player.name
        player.puts "End of assign_players_to_room_players"
      end
    end
  end

  # def run
  #   loop do
  #     player_status = room_players.each {|player| player.gets.chomp}
  #     if player_status == "Ready"
  #       start_game
  #     end
  #     room_players.each {|player| player.puts game}
  #     if game.winner
  #       game.winner.puts "You Won"
  #     end
  #   end
  # end
  
  def play_game
    
  end

  def display_message_to_client

  end

  def display_message_to_group

  end
end