require 'helper'

class TestCard < Test::Unit::TestCase
  def setup
    @card = Uno::Card.new('foo', 'bar')
  end
  
  def test_to_s
    assert_equal('foo bar', @card.to_s)
  end
end
