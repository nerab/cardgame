module CardGame
  module Player
    #
    # Carries the base functionality of a player, except the actual +play!+ implementation
    #
    class Base
      attr_reader :name, :violations

      def initialize(name)
        @name = name
        @hand = []
        @violations = []
      end

      def to_s
        "Player #{name} (#{hand.size} cards, score #{score}, #{@violations.size} rule violations)"
      end

      def score
        @hand.inject(0){|sum, c| sum += c.score}
      end

      def hand
        @hand.entries
      end
    
      def rule_violation(violation)
        @violations << violation
      end

      def draw(draw_pile, count = 1)
        count.times{
          card = draw_pile.draw
          LOGGER.info "#{self} draws #{card}"
          @hand << card
        }    
      end
    end
  end
end