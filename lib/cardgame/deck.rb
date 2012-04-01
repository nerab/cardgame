require 'forwardable'

module CardGame
  class Deck
    class << self
      def score(rank, suite = nil)
        0 
      end
      
      def ranks
        []
      end

      def trumps
        []
      end

      def suits
        []
      end
    end
    
    extend Forwardable
    
    def initialize
      @cards = []
      
      self.class.ranks.each{|rank|
        self.class.suits.each{|suite|
          push Card.new(rank, self.class.score(rank, suite), suite)
        }
      }
      
      self.class.trumps.each{|t| push Trump.new(t, self.class.score(t))}
    end
    
    #
    # Deal out a shuffled deck
    #
    def deal
      @cards.sort_by{rand}
    end
    
    def_delegator :@cards, :size
    
    private
    def_delegator :@cards, :push
  end
end