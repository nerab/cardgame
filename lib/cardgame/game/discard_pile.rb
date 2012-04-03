module CardGame
  module Game
    class DiscardPile
      extend Forwardable
      def_delegator :@pile, :push
      def_delegator :@pile, :last, :top
      
      def initialize
        @pile = []
      end
    end
  end
end