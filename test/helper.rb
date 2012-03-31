$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'test/unit'
require 'cardgame'
require 'yaml'
require 'json'
require 'active_support/core_ext/string'

class Test::Unit::TestCase
end

module CardGameTest
  class TestCase < Test::Unit::TestCase
    FIXTURES_DIR = File.join(File.dirname(__FILE__), 'fixtures')

    def fixture(name = self.class.name.underscore.match(/test_(.*)/)[1])
      file_name = nil
      
      %w{.yaml .yml .json}.each{|ext| 
        file_name = File.join(FIXTURES_DIR, "#{name}#{ext}")
        break if File.exist?(file_name)
      }

      raw = File.read(file_name)

      case File.extname(file_name)
      when '.yaml'
        YAML.load(raw)
      when '.json'
        JSON.parse(raw, :symbolize_names => true)
      else
        raw
      end
    end
  end

  module DeckTests
    def test_suits
      assert_equal(fixture[:suits], @deck.class.suits)
    end

    def test_trumps
      assert_equal(fixture[:trumps], @deck.class.trumps)
    end

    def test_ranks
      assert_equal(fixture[:ranks], @deck.class.ranks)
    end
  end
end