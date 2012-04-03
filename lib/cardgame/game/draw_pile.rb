module CardGame
  module Game
    class DrawPile
      extend Forwardable
      def_delegator :@pile, :pop, :draw
      def_delegator :@pile, :empty?
      
      def initialize
        @pile = Deck::Uno.new.deal
      end
      
      def replenish(discard_pile)
        @pile.concat(discard_pile)
        discard_pile.clear
        discard_pile.push(@pile.pop) # the last card stays on the discard pile
        @pile.sort_by!{rand}
      end
    end
  end
end