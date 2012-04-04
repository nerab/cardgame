require 'auto_player'

module CardGame
  module Player
    class LazyPlayer < AutoPlayer
      def initialize(name, max_thinktime)
        super(name)
        @max_thinktime = max_thinktime
      end

      def play(top_card)
        if 0 < @max_thinktime
          thinktime = rand(@max_thinktime)
          thinktime = 1 if 1 > thinktime # sleep at least one second
          LOGGER.info "#{self} needs #{thinktime} second(s) think time before he can play ..."
          sleep(thinktime) 
          LOGGER.debug "#{self} has made up his mind and is now going to play."
        end

        super
      end
    end
  end
end
