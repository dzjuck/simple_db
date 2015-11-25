module IndexFinder
  class BPlusTree < Base
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
        case condition
          when Condition::Equal
            cond_res = index.search(condition.value)
            if cond_res.nil?
              cond_res = {}
            else
              cond_res = cond_res.value
            end
          when Condition::Between
            cond_res = {}
            leaf, _ = index.search_leaf(condition.min_value)
            node = leaf.search_lower_bound(condition.min_value) 
            begin
              # можем найти nil, тогда переходим к следующему листу
              unless node.nil?
                cond_res.merge!(node.value)
                node = node.next
              end
              if node.nil?
                leaf = leaf.next
                node = leaf.list.first unless leaf.nil?
              end
            end while (node && node.key < condition.max_value)
        end

        res = combine(cond_res, res)
        break if res.empty?
      end

      rows_by_keys(res.keys)
    end

  end
end