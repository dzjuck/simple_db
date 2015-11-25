require_relative '../simple_db'

module ConditionGenerator
  class Array
    def initialize
      @res = []
      @fields = SimpleDb::FIELDS_RANGES
      @equal = ConditionGenerator::Equal.new(@fields)
      @between = ConditionGenerator::Between.new(@fields)
    end

  private

    def conds
      conds = rand(1..5).times.map do 
        generate_condition(generate_field)
      end

      '[' + conds.join(', ') + ']'
    end

    def generate_condition(field)
      return generate_equal(field) unless field_is_numeric?(field)

      case rand(0..1) 
      when 0
        generate_equal(field)
      when 1
        generate_between(field)
      end
    end

    def field_is_numeric?(field)
      field != :sex
    end

    def generate_equal(field)
      @equal.generate(field)
    end

    def generate_between(field)
      @between.generate(field)
    end

  end
end