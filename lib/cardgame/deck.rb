require 'forwardable'

module CardGame
  class Deck
    class << self
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
      
      self.class.ranks.each{|name|
        self.class.suits.each{|color|
          push Card.new(name, color)
        }
      }
      
      self.class.trumps.each{|j| push Trump.new(j)}
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