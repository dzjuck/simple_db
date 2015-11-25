require_relative 'condition_generator/array'
require_relative 'condition_generator/array_with_repeats'
require_relative 'condition_generator/array_without_repeats'
require_relative 'condition_generator/equal'
require_relative 'condition_generator/between'

module ConditionGenerator
  def self.generate(path = 'spec/support/conditions_list.rb')
    without_repeats = ArrayWithoutRepeats.new
    with_repeats = ArrayWithRepeats.new
    conditions_list = []
    67.times { conditions_list << without_repeats.generate }
    33.times { conditions_list << with_repeats.generate }
    res = 
      "conditions_list = [\n  " + 
      conditions_list.join(", \n  ") +
      "\n]"
    File.write(path, res)
  end
end