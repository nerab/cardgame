module CardGame
  module Deck
    class Base
      extend Forwardable
    
      def initialize
        @cards = []
      end
    
      #
      # Deal out a shuffled deck
      #
      def deal
        @cards.sort_by{rand}
      end
    
      def_delegator :@cards, :size
    
      protected
      def_delegator :@cards, :push
    end
  end
end