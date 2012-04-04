module CardGame
  module Deck
    class French < Base
      class << self
        def suits
          %w{Clubs Spades Hearts Diamonds}
        end
      end
      
      def initialize
        super
        self.class.suits.each{|suite|
          push Cards::NumberedCard.new('Ace', 0, suite)
          
          2.upto(10).each{|rank|
            push Cards::NumberedCard.new(rank, suite)
          }
          
          push Cards::NumberedCard.new('Knave', 11, suite)
          push Cards::NumberedCard.new('Queen', 12, suite)
          push Cards::NumberedCard.new('King', 13, suite)
        }
      end
    end
  end
end
