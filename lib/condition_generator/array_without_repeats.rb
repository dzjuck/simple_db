module ConditionGenerator
  class ArrayWithoutRepeats < Array

    def generate
      @tmp_fields = @fields.keys.shuffle
      conds
    end

  private

    def generate_field
      @tmp_fields.pop
    end

  end
end