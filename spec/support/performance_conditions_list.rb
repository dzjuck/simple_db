# require_relative '../../lib/condition'
require_relative '../../lib/simple_db'

PERFORMANCE_CONDITIONS_LIST = [
  # Without repeats
  [Condition::Between.new(:age, 9, 78), Condition::Between.new(:index, 603195, 644002), Condition::Equal.new(:sex, 1)], 
  [Condition::Equal.new(:amount, 751803), Condition::Equal.new(:sex, 1), Condition::Between.new(:index, 207292, 996610), Condition::Between.new(:height, 150, 222)], 
  [Condition::Between.new(:amount, 433162, 701766)], 
  [Condition::Between.new(:height, 57, 206), Condition::Between.new(:index, 340778, 782813)], 
  [Condition::Between.new(:height, 57, 206), Condition::Between.new(:index, 340778, 782813), Condition::Between.new(:age, 50, 73)], 
  [Condition::Equal.new(:sex, 1), Condition::Between.new(:height, 57, 206), Condition::Between.new(:index, 340778, 782813), Condition::Between.new(:age, 50, 73)], 
  [Condition::Equal.new(:age, 98)], 
  [Condition::Equal.new(:age, 98), Condition::Equal.new(:height, 24)], 
  [Condition::Between.new(:age, 20, 36), Condition::Equal.new(:index, 337063), Condition::Equal.new(:age, 8), Condition::Equal.new(:index, 854766), Condition::Equal.new(:sex, 1)], 

  # With repeats
  [Condition::Equal.new(:amount, 187959), Condition::Between.new(:amount, 312672, 632577)], 
  [Condition::Between.new(:index, 364605, 910522), Condition::Equal.new(:sex, 1), Condition::Between.new(:amount, 538905, 939553), Condition::Between.new(:index, 43505, 254191), Condition::Equal.new(:age, 70)], 
  [Condition::Equal.new(:sex, 1), Condition::Equal.new(:height, 171), Condition::Between.new(:amount, 414371, 728874), Condition::Between.new(:height, 85, 124), Condition::Equal.new(:amount, 211396)]
]

SHORT_PERFORMANCE_CONDITIONS_LIST = [
  [Condition::Equal.new(:age, 98)], 
  [Condition::Between.new(:amount, 700000, 701766)], 
  [Condition::Between.new(:amount, 433162, 701766)], 
  [Condition::Between.new(:amount, 433162, 701766), Condition::Between.new(:index, 364605, 910522)], 
]
