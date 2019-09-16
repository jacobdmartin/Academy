require_relative '../lib/player'
require_relative '../lib/game'

# you want to know everything about what happened.
#inquiring player
#inquired player
#inquired rank
#something about what happened
#give me a summary for player 3

class GameResult
  attr_reader :player_results, :game
  attr_accessor :player_results 

  def initialize(inquiring_player, inquired_player, rank, game)
    @player_results = 
    { 
      inquiring_player_no_rank_message: "#{inquiring_player} you don't have a #{rank}, ask for a different rank", 
      inquring_player_take_rank_message: "#{inquiring_player} took a #{rank} from #{inquired_player}", 
      inquired_player_no_rank_message: "#{inquiring_player} asked for a #{rank} from #{inquired_player} but had to Go Fish", 
      inquiring_player_fished_rank: "#{inquiring_player} fished what they asked for, #{inquiring_player} take another turn" 
    }
    @game = game
  end

  def go_fish(player)
    game.go_fish(player)
  end

  def turn_outcomes(inquiring_player, inquired_player, rank)
    if inquiring_player.has_card?(rank) == false
      player_results[:inquiring_player_no_rank_message]
    elsif inquiring_player.has_card?(rank) && inquired_player.has_card?(rank)
      remove_cards = inquired_player.remove_from_hand(rank)
      inquiring_player.add_cards_to_hand(remove_cards)
      player_results[:inquiring_player_take_rank_message]
    elsif inquired_player.has_card?(rank) == false
      new_card = game.go_fish(inquiring_player)
      if new_card.rank == rank
        player_results[:inquiring_player_fished_rank]
        current_player = inquiring_player
      else
        game.advance_player
        player_results[:inquired_player_no_rank_message]
      end
    end
  end

  def return_cards
    
  end

  def player_takes_card_from_player(inquiring_player, inquired_player, rank)

  end

  def player_goes_fishing

  end
end