require "#{File.dirname(__FILE__)}/example_helper.rb"

class MyFirstTest
  include Compleat::Testing::Helpers

  def test_foo
    assert_equal "foo", "bar"
  end

  def test_bar
    assert("1 + 1 should equal 2") { 1 + 1 == 3 }
  end
end

class MySecondTest
  include Compleat::Testing::Helpers

  def setup
    @x = 1
  end

  def test_baz
    raise NotImplementedError
  end

  def test_quux
    assert { @x == 1 }
  end

  def test_foobar
    assert_equal @x, 1
  end
end
