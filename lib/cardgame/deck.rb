require 'forwardable'

module CardGame
  class Deck
    extend Forwardable
    
    def initialize
      @cards = []
      
      ranks.each{|name|
        suits.each{|color|
          push Card.new(name, color)
        }
      }
      
      trumps.each{|j| push Trump.new(j)}
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
    
    def_delegator :@cards, :push
    def_delegator :@cards, :<<
    def_delegator :@cards, :pop
    def_delegator :@cards, :size
  end
end