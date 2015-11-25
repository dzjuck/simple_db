module ConditionGenerator
  class Between
    def initialize(fields)
      @fields = fields
    end

    def generate(field)
      min, max = [
        rand(@fields[field]), 
        rand(@fields[field])
      ].sort
      "Condition::Between.new(:#{field}, #{min}, #{max})"
    end
  end
end