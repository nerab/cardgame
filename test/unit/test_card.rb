require 'helper'

class TestCard < CardGameTest::TestCase
  def setup
    @card = CardGame::Card.new('foo', 6, 'bar')
  end
  
  def test_rank
    assert_equal('foo', @card.rank)
  end
  
  def test_suit
    assert_equal('bar', @card.suit)
  end
  
  
  def test_score
    assert_equal(6, @card.score)
  end
end
