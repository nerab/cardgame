module CardGame
  class Uno < Deck
    class << self
      CARDS = {
        :_0            => {:name => '0',           :score => 0,  :count => 1},
        :_1            => {:name => '1',           :score => 1,  :count => 2},
        :_2            => {:name => '2',           :score => 2,  :count => 2},
        :_3            => {:name => '3',           :score => 3,  :count => 2},
        :_4            => {:name => '4',           :score => 4,  :count => 2},
        :_5            => {:name => '5',           :score => 5,  :count => 2},
        :_6            => {:name => '6',           :score => 6,  :count => 2},
        :_7            => {:name => '7',           :score => 7,  :count => 2},
        :_8            => {:name => '8',           :score => 8,  :count => 2},
        :_9            => {:name => '9',           :score => 9,  :count => 2},
        :_reverse      => {:name => 'Reverse',     :score => 20, :count => 2},
        :_skip         => {:name => 'Skip',        :score => 20, :count => 2},
        :_draw_2       => {:name => 'Draw 2',      :score => 20, :count => 2},
      }

      TRUMPS = {
        :_wild_draw_4  => {:name => 'Wild Draw 4', :score => 50, :count => 4},
        :_wild         => {:name => 'Wild',        :score => 50, :count => 4},
      }
      
      def score(rank, suite = nil)
        result = CARDS.merge(TRUMPS)[rank] # Uno calculates score solely based on the card's rank
        raise "Unknown card #{rank}" unless result
        result[:score]
      end
    
      def ranks
        multiplied(CARDS)
      end
    
      def trumps
        multiplied(TRUMPS)
      end
    
      def suits
        %w{Blue Green Red Yellow}
      end
      
      private
      def multiplied(definition)
        ranks = []
        definition.each{|id, properties|
          ranks.concat([id] * properties[:count])
        }
        ranks
      end
    end
  end
end