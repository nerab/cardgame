require 'helper'
require 'awesome_print'

class TestUno < CardGameTest::TestCase
  include CardGame
  include CardGameTest::DeckTests
  
  def setup
    @deck = Uno.new
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
