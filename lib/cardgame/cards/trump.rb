module CardGame
  module Cards
    class Trump < Card
      # When playing a trump card, it's the player who decides which suit it has, so that the next player has to follow it
      attr_accessor :suit
    
      def initialize(rank, score)
        super(rank, score)
      end

      def trump?
        true
      end
    
      def to_s
        "#{rank.to_s.titleize} requiring #{suit.to_s.titleize}" # . Card is #{armed? ? '' : 'NOT '}armed.
      end
    
      def to_sym
        super.to_s.underscore.to_sym
      end
    end
  end
end