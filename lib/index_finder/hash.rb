module IndexFinder
  class Hash < Base
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
        cond_res = index[condition.value] || {}

        res = combine(cond_res, res)
        break if res.empty?
      end

      rows_by_keys(res.keys)
    end

  end
end