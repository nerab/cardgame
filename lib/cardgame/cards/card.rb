require 'active_support/core_ext/string'

module CardGame
  module Cards
    class Card
      extend Forwardable
      def_delegator :@sad, :armed?
      def_delegator :@sad, :arm!
      def_delegator :@sad, :disarm!
      def_delegator :@sad, :fire!
      
      attr_reader :rank, :suit, :score
    
      def initialize(rank, score, suit = nil)
        @rank, @score, @suit = rank, score, suit
        @sad = SafeArmFireDevice.new
      end
    
      #
      # The following card only matches this one if both have either the same suit (color) or the same rank
      #
      # TODO Potentially implement this differently in trumps
      #
      def matches?(following_card)
        rank == following_card.rank || suit == following_card.suit
      end
    
      def trump?
        false
      end
    
      def to_s
        "#{suit.to_s.titleize} #{rank.to_s.titleize}" # . Card is #{armed? ? '' : 'NOT '}armed.
      end
    
      def to_sym
        to_s.underscore.to_sym
      end
    end
  end
end