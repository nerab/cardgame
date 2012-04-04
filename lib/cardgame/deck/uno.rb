module CardGame
  module Deck
    class Uno < Base
      class << self
        def suits
          [:blue, :green, :red, :yellow]
        end
      end
      
      def initialize
        super
        self.class.suits.each{|suite|
          push Cards::NumberedCard.new(0, suite)
          
          1.upto(9).each{|rank|
            2.times{push Cards::NumberedCard.new(rank, suite)}
          }
          
          2.times{
            push Cards::Uno::Reverse.new(suite)
            push Cards::Uno::Skip.new(suite)
            push Cards::Uno::Draw2.new(suite)
          }
        }
        
        4.times{
          push Cards::Uno::Wild.new
          push Cards::Uno::WildDraw4.new
        }
      end
    end
  end
end