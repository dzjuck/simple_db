module Finder
  class Base

  protected
  
    def separate_conditions(conditions)
      equal = []
      between = []
      conditions.each do |condition|
        case condition
        when Condition::Equal
          equal << condition
        when Condition::Between
          between << condition
        end
      end
      [equal, between]
    end

    def build_indexes(indexes, check_key, klass = nil)
      return indexes[check_key] unless indexes.nil?
      
      class_name(IndexBuilder, klass).new(@data).build
    end

    def class_name(_module = nil, klass = nil)
      klass = klass.nil? ? self.class.name : klass.to_s
      klass = klass.split('::').last
      klass = Object.const_get("#{_module}::#{klass}") if _module
      klass
    end
  end
end
