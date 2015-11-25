require_relative '../b_plus_tree'

module Finder
  class BPlusTreeSimple < Base
    def initialize(data, indexes = nil)
      @data = data
      @indexes = build_indexes(indexes, :tree, BPlusTree)
      @finders = {
        b_plus_tree: IndexFinder::BPlusTree.new(@data, @indexes),
        full_scan: IndexFinder::FullScan.new(@data, @indexes)
      }
    end

    def find(conditions)
      return @data if conditions.empty?

      res = {}

      equal, between = separate_conditions(conditions)
      conditions = equal + between
      conditions_by_index = conditions.shift(1)

      res = @finders[:b_plus_tree].find(conditions_by_index)
      @finders[:full_scan].find(conditions, res)
    end
  end
end
