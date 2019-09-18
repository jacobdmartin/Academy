require_relative '../lib/card_deck'
require_relative '../lib/player'

describe 'CardDeck' do

  describe '#stock_deck' do
    it 'stocks the deck with cards' do
      card_deck = CardDeck.new
      expect(card_deck).to_not be_nil
    end
  end
  
  #ASK KEN ABOUT THIS DUPLICATE TEST (GAME_SPEC)
  #WHICH ONE IS NECESSARY OR ARE BOTH?
  describe '#shuffle' do 
    it 'shuffles the deck of cards' do
      game1 = GoFishGame.new(["Bill"])
      game2 = GoFishGame.new(["Louis"])
      game1.start
      expect(game1.card_deck).to_not eq(game2.card_deck)
    end
  end

  describe '#deal' do
    it 'deals a single card to a given players hand' do
      card_deck = CardDeck.new
      card_deck.shuffle
      player = GoFishPlayer.new(["Bill"])
      card = card_deck.deal
      player.add_cards_to_hand(card)
      expect(player.hand.count).to eq 1
    end
  end

  describe '#cards_left' do
    it 'counts the cards left in the card_deck' do
      card_deck = CardDeck.new
      player = GoFishPlayer.new(["Joey"])
      card_deck.shuffle
      card = card_deck.deal
      expect(card_deck.cards_left).to eq 51
    end
  end
end