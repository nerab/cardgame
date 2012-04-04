module CardGame
  module Game
    class DiscardPile
      extend Forwardable
      def_delegator :@pile, :last, :top
      def_delegator :@pile, :size
      def_delegator :@pile, :to_ary
      def_delegator :@pile, :clear

      def initialize
        @pile = []
      end

      #
      # Recycle one or more cards so that they are in the discard pile, but not at the top
      #
      def recycle(cards)
        LOGGER.debug "Recycling #{cards.size} cards: #{self}"
        return if cards.nil?

        top = @pile.pop

        if cards.respond_to?(:pop) # is it an array?
          @pile.concat(cards)
        else
          @pile.push(cards)
        end

        @pile.push(top)
        LOGGER.debug "Done recycling: #{self}"
      end
      
      #
      # Re-arm card after it was pushed onto the discard pile
      #
      def push(card)
        @pile.push(card)
        card.arm!
      end

      def to_s
        "#{self.class.name.demodulize} with #{@pile.size} cards, #{top} on top"
      end
    end
  end
end
