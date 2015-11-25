module IndexFinder
  class FullScan
    def initialize(data, index = nil)
      @data = data
      @index = index
    end

    def find(conditions, rows = nil)
      data = rows.nil? ? @data : rows
      return data if conditions.empty?
      
      data.keep_if do |row|
        check(row, conditions)
      end
    end

  private

    def check(row, conditions)
      conditions.each do |condition|
        return false unless condition.check(row)
      end
      true
    end

  end
end