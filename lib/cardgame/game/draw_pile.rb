module CardGame
  module Game
    class DrawPile
      extend Forwardable
      def_delegator :@pile, :empty?
      def_delegator :@pile, :size
      
      def initialize(deck, discard_pile)
        @discard_pile = discard_pile
        @pile = deck.deal
      end

      def draw
        replenish! if empty?
        @pile.pop
      end
      
      private
      def replenish!
        @pile.concat(@discard_pile)
        @discard_pile.clear
        @discard_pile.push(@pile.pop) # the last card stays on the discard pile
        @pile.sort_by!{rand}
      end
    end
  end
end