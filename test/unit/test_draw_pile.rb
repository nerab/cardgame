require 'helper'

class TestDrawPile < Test::Unit::TestCase
  def setup
    @deck = CardGame::Deck::Uno.new
    @discard_pile = CardGame::Game::DiscardPile.new
    @draw_pile = CardGame::Game::DrawPile.new(@deck, @discard_pile)
  end

  def test_draw
    assert_equal(@deck.size, @draw_pile.size + @discard_pile.size)
    card = @draw_pile.draw
    assert(!card.nil?)
    assert_equal(@deck.size - 1, @draw_pile.size + @discard_pile.size)
  end

  def test_draw2
    assert_equal(@deck.size, @draw_pile.size + @discard_pile.size)
    card = @draw_pile.draw
    assert(!card.nil?)
    card = @draw_pile.draw
    assert(!card.nil?)
    assert_equal(@deck.size - 2, @draw_pile.size + @discard_pile.size)
  end
  
  # draw more than the size of the draw pile and make sure it's replenished
  def test_auto_replenish
    (@deck.size * 2).times{
      card = @draw_pile.draw
      assert(!card.nil?)
      @discard_pile.push(card)
    }
    assert_equal(@deck.size, @draw_pile.size + @discard_pile.size)
  end
end