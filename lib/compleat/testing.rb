module Compleat
  module Testing
    extend self

    def targets
      @targets ||= []
    end

    def each_test_case
      targets.each do |test_class|
        test_class.instance_methods.grep(/^test_/).each do |test_method|
          yield test_class, test_method
        end
      end
    end

    def run_tests
      tests_executed, tests_failed, tests_error = 0,0,0

      each_test_case do |test_class, test_method|
        tests_executed += 1

        begin
          test_obj = test_class.new
          test_obj.send(:setup)
          test_obj.send(test_method)
        rescue Compleat::Testing::FailedAssertion => e
          puts "Failure in #{test_class}##{test_method}:"
          puts "  #{e.message}"
          tests_failed += 1
        rescue Exception => e
          puts "Error in #{test_class}##{test_method}:\n"
          puts "  #{e.message}"
          tests_error += 1
        end
      end

      puts "\n#{tests_executed} tests ran, #{tests_failed} failed, " +
           "#{tests_error} errors"
    end

    FailedAssertion = Class.new(StandardError)

    module Helpers
      def self.included(base)
        base.extend(ClassMethods)
        Compleat::Testing.targets << base
      end

      module ClassMethods
        # code stolen from citrusbyte/contest, edited for brevity
        def test(name, &block)
          tname = "test_#{name.gsub(/\W+/, ' ').strip.gsub(/\s+/,'_')}".to_sym
          define_method(tname, &block)
        end
      end

      def setup
        # just a stub for extension
      end

      def assert(msg="Things did not go as expected")
        yield || raise(FailedAssertion, msg)
      end

      def assert_equal(a,b)
        assert("Expected #{a.inspect}, but got #{b.inspect}") { a == b }
      end
    end
  end
end

at_exit do
  Compleat::Testing.run_tests
end
