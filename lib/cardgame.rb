require 'cardgame/version'
require 'cardgame/card'
require 'cardgame/player'

require 'cardgame/deck/base'
require 'cardgame/deck/uno'
require 'cardgame/deck/french'

require 'cardgame/game/uno'
require 'cardgame/game/draw_pile'
require 'cardgame/game/discard_pile'

require 'logger'

module CardGame
  LOGGER = Logger.new(STDERR)
end