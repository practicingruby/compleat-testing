require "#{File.dirname(__FILE__)}/example_helper.rb"

class Foo
  include Compleat::TestHelpers
end

class Bar
  include Compleat::TestHelpers
end

class Baz
  # this will not be detected
end
