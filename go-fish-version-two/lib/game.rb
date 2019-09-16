#TSTTCPW (the simplest thing that can possibly work)
#initialize: card deck, players
#shuffle cards
#deal cards

require_relative '../lib/room'
require_relative '../lib/room_player'
require_relative '../lib/server'
require_relative '../lib/playing_card'
require_relative '../lib/player'
require_relative '../lib/results'
require 'pry'

class GoFishGame
  attr_reader :card_deck, :players, :current_player, :game

  def initialize(*players_names)
    @card_deck = CardDeck.new
    @players = players_names.map {|player_name| GoFishPlayer.new(player_name)}
    @current_player = @players[0]
  end

  def start
    card_deck.shuffle
  end 

  def deal_count
    players.count >= 3 ? 5 : 7
  end

  def add_cards_to_hand(*cards)
    cards.each {|card| hand.push(card)}
  end

  def deal_cards
    deal_count.times do 
      players.each {|player| player.add_cards_to_hand(card_deck.deal)}
    end
  end

  def go_fish(player)
    card = card_deck.deal
    player.add_cards_to_hand(card)
    card
  end

  def inquire_for_card(inquiring_player, inquired_player, rank)
    result = GameResult.new(inquiring_player, inquired_player, rank, self)
    result.turn_outcomes(inquiring_player, inquired_player, rank)
  end

  def advance_player
    if current_player = players.last
      current_player
    else
      current_player = players[players.index(current_player + 1)]
    end
  end
end