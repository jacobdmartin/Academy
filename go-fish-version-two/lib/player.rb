#says start game
#look at hand and see if they have cards

require_relative '../lib/game'
require_relative '../lib/playing_card'
require 'pry'

class GoFishPlayer
  attr_reader :name, :hand, :completed_matches

  def initialize(name)
    @name = name
    @hand = []
    @completed_matches = []
  end

  def remove_from_hand(rank)
    inquired_rank = []
    hand.each do |card| 
      inquired_rank.push(hand.delete(card)) if card.value == value(rank)
    end
    inquired_rank
  end

  def has_card?(rank)
    hand.map(&:rank).include?(rank)
  end

  def add_cards_to_hand(*cards)
    cards.each {|card| hand.push(card)}
  end

  def card_rank_counter
    card_rank_counter = Hash.new(0)
    hand.each {|card| card_rank_counter[card.rank] += 1}
    card_rank_counter
  end

  def count_matches_in_hand
    card_rank_counter.each do |rank, cards|
      cards == 4 ? completed_matches.push(hand.delete(rank)) : false
    end
  end

  private

  def value(rank)
    return 11 if rank == "Jack"
    return 12 if rank == "Queen"
    return 13 if rank == "King"
    return 14 if rank == "Ace"
    rank.to_i
  end
 end
