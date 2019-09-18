require_relative '../lib/results'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/playing_card'
require 'pry'

describe 'GameResults' do 
  let(:five_of_clubs) {PlayingCard.new("5", "Clubs")}
  let(:eight_of_diamonds) {PlayingCard.new("8", "Diamonds")}
  let(:five_of_spades) {PlayingCard.new("5", "Spades")}
  let(:queen_of_hearts) {PlayingCard.new("Queen", "Hearts")}
  let(:ace_of_diamonds) {PlayingCard.new("Ace", "Diamonds")}

  describe '#go_fish' do
    it 'tells a given player to go_fish' do
      game = GoFishGame.new("Billy", "Joella")
      game.start
      game.deal_count
      game.deal_cards
      game.go_fish(game.players[0])
      expect(game.players[0].hand.count).to eq 8
      expect(game.card_deck.cards_left).to eq 37
    end
  end

  describe '#return_cards' do
    # it 'returns a message if a round results in a given player receiving a card' do
    #   @game = GoFishGame.new("Spain", "Meeker")
    #   @game.
    # end

    it 'returns a message if a round results in a given player asking for a rank they don\'t have' do
      game = GoFishGame.new("Andrew", "Garfield")
      result = GameResult.new(game.players[0].name, game.players[1].name, "Ace", game)
      game.players[0].add_cards_to_hand(five_of_clubs, eight_of_diamonds)
      game.players[1].add_cards_to_hand(five_of_spades, queen_of_hearts)
      game.inquire_for_card(game.players[0], game.players[1], "Ace")
      expect(result.turn_outcomes(game.players[0], game.players[1], "Ace")).to eq result.player_results[:inquiring_player_no_rank_message]
    end

    it 'returns a message if a round results in a given player having to go fish' do
      game = GoFishGame.new("Matt", "Damon")
      result = GameResult.new(game.players[0].name, game.players[1].name, "8", game)
      game.players[0].add_cards_to_hand(five_of_clubs, eight_of_diamonds)
      game.players[1].add_cards_to_hand(five_of_spades, queen_of_hearts)
      game.inquire_for_card(game.players[0], game.players[1], "8")
      expect(result.turn_outcomes(game.players[0], game.players[1], "8")).to eq result.player_results[:inquired_player_no_rank_message]
      expect(game.players[0].hand.count).to eq 4
      expect(game.players[1].hand.count).to eq 2
    end

    # it 'returns a message if a given player gets to go again because they fished what they asked for' do
    #   @game = GoFishGame.new("Spain", "Meeker")
    #   result = GameResult.new(@game.players[0].name, @game.players[1].name, "Ace")
    #   @game.players[0].add_cards_to_hand(five_of_clubs, eight_of_diamonds, ace_of_diamonds)
    #   @game.players[1].add_cards_to_hand(five_of_spades, queen_of_hearts)
    #   # @game.inquire_for_card(@game.players[0], @game.players[1], "Ace")
    #   expect(@game.inquire_for_card(@game.players[0], @game.players[1], "Ace")).to eq result.player_results[:inquiring_player_fished_rank]
    # end
  end
end

# @game.fish_rank_asked_for(@game.players[0], @game.players[1], "Ace")