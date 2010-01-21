module Compleat
  module Testing
    extend self

    def run_tests
      puts "This is the hook that will run your tests"
    end
  end
end

at_exit do
  Compleat::Testing.run_tests
end
