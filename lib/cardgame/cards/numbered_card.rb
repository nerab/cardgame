module CardGame
  module Cards
    class NumberedCard < Card
      def initialize(rank_or_label, suit_or_rank, suit_or_nil = nil)
        if suit_or_nil.nil?
          super(rank_or_label.to_s, rank_or_label, suit_or_rank)
        else
          super(rank_or_label, suit_or_rank, suit_or_nil)
        end
      end
    end
  end
end