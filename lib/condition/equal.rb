module Condition
  class Equal
    attr_reader :field, :value

    def initialize(field, value)
      @field = field
      @key = SimpleDb::FIELDS_KEYS[field]
      @value = value
    end

    def check(row)
      @value == row[@key]
    end

    def to_s
      "`#{@field}` equal #{@value}"
    end
  end
end
