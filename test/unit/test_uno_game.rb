require File.join(File.dirname(__FILE__), '..', 'helper')

class ViolatingPlayer < CardGame::Player::Base  
  def play(top_card)
    top_card
  end
end

class TestUnoGame < CardGameTest::TestCase
  def setup
    @players = []
    (1..2).each{|i| @players << CardGame::Player::AutoPlayer.new("T#{i}")}
    @game = Game::Uno.new(@players)
  end
  
  def test_game
    @players << CardGame::Player::AutoPlayer.new("T3") # add a third regular player
    @game.play!
    assert(0 < @game.rounds)

    # assert_equal(@winner, @game.winner)
    
    @players.each{|player|
      if @game.winner == player
        assert_equal(0, @game.winner.score)
        assert_equal(0, @game.winner.hand.size)
      else
        assert(0 < player.hand.size)
        assert(0 < player.score)
      end
    }
  end
  
  def test_game_with_violator
    violator = ViolatingPlayer.new('Violator')
    @players << violator
    @game.play!(3, 1)
    assert_nil(@players.index(violator), 'Violator must not take part in the game anymore')
  end
  
  def test_game_with_lazy_player
    lazy = CardGame::Player::LazyPlayer.new('LAZY', 3)
    @players << lazy
    @game.play!(0.1, 1)
    assert_nil(@players.index(lazy), "Lazy player must not take part in the game anymore")
  end
end
