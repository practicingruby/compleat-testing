require "#{File.dirname(__FILE__)}/example_helper.rb"

class MyFirstTest
  include Compleat::Testing::Helpers

  test "A failing assert_equal" do
    assert_equal "foo", "bar"
  end

  test "A failing assert" do
    assert("1 + 1 should equal 2") { 1 + 1 == 3 }
  end
end

class MySecondTest
  include Compleat::Testing::Helpers

  def setup
    @x = 1
  end

  test "An example of an error raising testcase" do
    raise NotImplementedError
  end

  test "An example of setup and assert" do
    assert { @x == 1 }
  end

  test "An example of setup and assert_equal" do
    assert_equal @x, 1
  end
end
