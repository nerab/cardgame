require 'helper'

class TestNumberedCard < CardGameTest::TestCase
  def setup
    @card = CardGame::Cards::NumberedCard.new(6, 'Violet')
  end
  
  def test_rank
    assert_equal('6', @card.rank)
  end
  
  def test_suit
    assert_equal('Violet', @card.suit)
  end
  
  def test_score
    assert_equal(6, @card.score)
  end
end
