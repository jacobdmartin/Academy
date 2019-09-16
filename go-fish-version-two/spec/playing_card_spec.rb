require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'creates a card with a rank and suit' do
    card = PlayingCard.new("2", "Hearts")
    expect(card.rank).to eq "2"
    expect(card.suit).to eq "Hearts"
  end

  it "should assign each card a value" do
    card = PlayingCard.new("Jack", "Clubs")
    card2 = PlayingCard.new("Queen", "Hearts")
    expect(card.value).to eq 11
    expect(card2.value).to eq 12
  end

  it 'returns true if player1 card equals the correct output string' do
    player1_card = PlayingCard.new("7", "Clubs")
    expect(player1_card.to_s).to eq("7 of Clubs")
  end
end
