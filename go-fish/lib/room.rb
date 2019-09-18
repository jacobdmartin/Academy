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
  attr_accessor :room_players, :game
  
  def initialize(room_players)
    @room_players = room_players
  end

  def start_game
    game = GoFishGame.new(player_names)
    game.start
    game
  end

  def player_names
    room_players.map {|room_player| room_player.name}
  end

  def run
    self.game = start_game
    assign_players_to_room_players
    client_input
  end

  def client_input
    puts "It is #{game.current_player}'s' turn"
    room_players.each do |room_player| 
      input = room_player.client.gets.chomp if is_current_player?(room_player)
    end
    game.check_client_input(input)
  end

  def check_client_input(input)
    expected_input = "(\w+)\s(from)\s([a-zA-Z]+)"
    input == expected_input ? true : false
  end

  def assign_players_to_room_players
    game.players.each do |player|
      room_players.each do |room_player|
        room_player.player = player if room_player.name == player.name
      end
    end
  end

  private 

  def is_current_player?(room_player)
    room_player.name == game.current_player.name
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