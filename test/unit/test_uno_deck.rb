require File.join(File.dirname(__FILE__), '..', 'helper')

class TestUnoDeck < CardGameTest::TestCase
  include CardGame
  
  def setup
    @deck = Deck::Uno.new
  end
  
  def test_size
    assert_equal(108, @deck.size)
  end
  
  def test_total_score
    assert_equal(1240, @deck.deal.inject(0){|sum, card| 
      sum + card.score
    })
  end
end
