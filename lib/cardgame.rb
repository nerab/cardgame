require 'logger'
require 'forwardable'

# recursively require all ruby files, adding their path to the load path
Dir[File.dirname(__FILE__) + "/**/*.rb"].each do |file|
  $LOAD_PATH.unshift(File.dirname(file))
  require file
end

module CardGame
  LOGGER = Logger.new(STDERR)
  LOGGER.level = Logger::ERROR
end
