module CardGame
  class French < Deck
    class << self
      def score(rank, suite)
        42 # TODO Implement 
      end
      
      def ranks
        %w{Ace 2 3 4 5 6 7 8 9 10 Knave Queen King}
      end
    
      def trumps
        []
      end
    
      def suits
        %w{Clubs Spades Hearts Diamonds}
      end
    end
  end
end