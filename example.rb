require_relative 'lib/simple_db.rb'

data_path = 'spec/fixtures/data/10_rows.csv'
db = SimpleDb.new(data_path, Finder::Hash)

conditions = [
  Condition::Equal.new(:sex, 1),
  Condition::Between.new(:height, 120, 210)
]
puts "Conditions: #{conditions.map(&:to_s)}"
found = db.find(conditions)
puts "Found rows: #{found}"
