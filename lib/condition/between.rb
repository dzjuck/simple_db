module Condition
  class Between
    attr_reader :field, :min_value, :max_value

    def initialize(field, min_value, max_value)
      @field = field
      @key = SimpleDb::FIELDS_KEYS[field]
      @min_value = min_value
      @max_value = max_value
    end

    def check(row)
      row[@key] >= @min_value && row[@key] < @max_value
    end

    def to_s
      "`#{@field}` between #{@min_value} and #{@max_value}"
    end
  end
end
