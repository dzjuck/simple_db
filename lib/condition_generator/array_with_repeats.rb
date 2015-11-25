module ConditionGenerator
  class ArrayWithRepeats < Array

    def generate
      conds
    end

  private

    def generate_field
      @fields.keys.shuffle.first
    end

  end
end