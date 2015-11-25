module Finder
  class Hash < Base
    def initialize(data, indexes = nil)
      @data = data
      @indexes = build_indexes(indexes, :hash)
      @finders = {
        hash: IndexFinder::Hash.new(@data, @indexes),
        full_scan: IndexFinder::FullScan.new(@data, @indexes)
      }
    end

    def find(conditions)
      return @data if conditions.empty?

      equal, between = separate_conditions(conditions)
      rows = equal_res(equal)
      between_res(rows, between)
    end

  private

    def equal_res(conditions)
      @finders[:hash].find(conditions)
    end

    def between_res(rows, conditions)
      @finders[:full_scan].find(conditions, rows)
    end

  end
end

