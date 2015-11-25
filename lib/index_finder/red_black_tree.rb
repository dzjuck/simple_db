module IndexFinder
  class RedBlackTree < Base
    def initialize(data, index = nil)
      @data = data
      @index = index
    end

    def find(conditions)
      return @data if conditions.empty?
      
      res = {}
      conditions.each do |condition|
        field = condition.field
        index = @index[field]
        cond_res = case condition
          when Condition::Equal
            index[condition.value] || {}
          when Condition::Between
            between_rows(index, condition)
          end

        res = combine(cond_res, res)
        break if res.empty?
      end

      rows_by_keys(res.keys)
    end

  private

    def between_rows(index, condition)
      res = {}
      index
        .bound(condition.min_value, condition.max_value-1)
        .each { |value, rows| res.merge!(rows) }

      res
    end
  end
end