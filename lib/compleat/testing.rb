module Compleat
  module Testing
    extend self

    def targets
      @targets ||= []
    end

    def run_tests
      targets.each { |e| puts "Detected test class: #{e.name}" } 
    end
  end

  module TestHelpers
    def self.included(base)
      Compleat::Testing.targets << base
    end
  end
end

at_exit do
  Compleat::Testing.run_tests
end
