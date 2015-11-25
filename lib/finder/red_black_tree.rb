module Finder
  class RedBlackTree < Base
    def initialize(data, indexes = nil)
      @data = data
      @indexes = build_indexes(indexes, :tree)
      @finder = IndexFinder::RedBlackTree.new(@data, @indexes)
    end

    def find(conditions)
      @finder.find(conditions)
    end
  end
end
