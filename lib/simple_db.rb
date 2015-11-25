require 'csv'

require_relative 'data_loader'
require_relative 'condition'
require_relative 'finder'

class SimpleDb
  FIELDS = [:sex, :age, :height, :index, :amount]

  FIELDS_KEYS = {sex: 0, age: 1, height: 2, index: 3, amount: 4}

  FIELDS_RANGES = {
    sex: 0..1,
    age: 0..100,
    height: 0..300,
    index: 0..1_000_000,
    amount: 0..1_000_000
  }

  def initialize(data_path, finder = Finder::FullScan, data_in = nil, indexes = nil)
    @data_path = data_path
    @data = data_in# unless data_in.nil?
    @finder = finder.new(data, indexes)
  end

  def find(conditions)
    @finder.find(conditions)
  end

private

  def data
    @data ||= DataLoader.new(@data_path).load
  end
end