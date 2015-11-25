module ConditionGenerator
  class Equal
    def initialize(fields)
      @fields = fields
    end

    def generate(field)
      value = rand(@fields[field])
      "Condition::Equal.new(:#{field}, #{value})"
    end
  end
end