require 'helper'

class TestSafeArmFireDevice < Test::Unit::TestCase
  def setup
    @sad = CardGame::SafeArmFireDevice.new
    @triggered = 0
  end

  def test_fire
    assert_equal(true, @sad.armed?)
    @sad.fire!(self){trigger}
    assert_equal(false, @sad.armed?)
    assert_equal(1, @triggered)
  end
  
  def test_fire_disarmed
    assert_equal(true, @sad.armed?)
    @sad.disarm!
    @sad.fire!(self){trigger}
    assert_equal(false, @sad.armed?)
    assert_equal(0, @triggered)
  end
  
  def test_fire_twice
    assert_equal(0, @triggered)
    assert_equal(true, @sad.armed?)
    @sad.fire!(self){trigger}
    assert_equal(false, @sad.armed?)
    assert_equal(1, @triggered)
    @sad.fire!(self){raise 'Must not fire twice'}
    assert_equal(false, @sad.armed?)
    assert_equal(1, @triggered)
  end

  def test_fire_twice_rearm
    assert_equal(0, @triggered)
    assert_equal(true, @sad.armed?)
    @sad.fire!(self){trigger}
    assert_equal(false, @sad.armed?)    
    assert_equal(1, @triggered)
    @sad.arm!
    @sad.fire!(self){trigger}
    assert_equal(false, @sad.armed?)
    assert_equal(2, @triggered)
  end
  
  # called by the block passed to the SAD device
  def trigger
    @triggered += 1
  end
end