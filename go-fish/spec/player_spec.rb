require_relative '../lib/player'

describe 'GoFishPlayer' do
  def initialize_two_players
    @player1 = GoFishPlayer.new("Mike")
    @player2 = GoFishPlayer.new("Joel")
  end

  def initialize_a_match_of_four
    @card1 = PlayingCard.new("5", "Clubs")
    @card2 = PlayingCard.new("8", "Diamonds")
    @card3 = PlayingCard.new("5", "Spades")
    @card4 = PlayingCard.new("5", "Diamonds")
    @card5 = PlayingCard.new("5", "Hearts")
  end

  def initialize_three_cards
    @card1 = PlayingCard.new("3", "Clubs")
    @card2 = PlayingCard.new("8", "Diamonds")
    @card3 = PlayingCard.new("3", "Spades")
  end

  describe '#remove_from_hand' do
    it 'it removes and returns an array of cards matching a rank from a players hand' do

    end
  end

  describe '#has_card?' do
    it 'returns a true if the player has the given rank in their hand' do
      player = GoFishPlayer.new("Billy")
      player.add_cards_to_hand(PlayingCard.new("4", "Spades"))
      player.add_cards_to_hand(PlayingCard.new("6", "Diamonds"))
      expect(player.has_card?("4")).to eq true
      expect(player.has_card?("Ace")).to eq false
    end

    it 'returns false if given player doesn\'t have given rank in hand' do
      player = GoFishPlayer.new("Danny")
      player.add_cards_to_hand(PlayingCard.new("5", "Clubs"))
      expect(player.has_card?("King")).to eq false
    end
  end

  describe '#add_cards_to_hand' do
    it 'adds an array of cards to a given players hand' do
      player = GoFishPlayer.new("Jamie")
      card1 = PlayingCard.new("3", "Clubs")
      card2 = PlayingCard.new("8", "Diamonds")
      player.add_cards_to_hand(card1, card2)
      expect(player.hand.count).to eq 2
    end
  end

  describe '#card_rank_counter' do
    it 'counts how many cards with each rank a player has' do
      player = GoFishPlayer.new("Jack")
      initialize_three_cards
      player.add_cards_to_hand(@card1, @card2, @card3)
      player.card_rank_counter
      expect(player.card_rank_counter.count).to eq 2
    end
  end

  describe '#count_matches_in_hand' do
    it 'if a given player has 4 of a rank, it is put into their completed_matches' do
      player = GoFishPlayer.new("Jack")
      initialize_a_match_of_four
      player.add_cards_to_hand(@card1, @card2, @card3, @card4, @card5)
      player.count_matches_in_hand
      expect(player.completed_matches.count).to eq 1
    end
  end
end