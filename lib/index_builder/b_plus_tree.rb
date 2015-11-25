require_relative '../b_plus_tree'

module IndexBuilder
  class BPlusTree
    DEGREE = 256

    def initialize(data)
      @data = data
    end

    def build
      # puts 'Begin b+ tree indexes building'
      res = {}
      fields = SimpleDb::FIELDS
      fields.each do |field|
        res[field] = ::BPlusTree::Tree.new(DEGREE)
      end

      # counter = 0
      @data.each_with_index do |row, row_index|
        # puts counter if (counter % 100_000).zero?; counter += 1
        fields.each_with_index do |field, field_index|
          value = row[field_index]
          index_values = res[field].search(value)
          if index_values.nil?
            index_values = {}
            index_values[row_index] = true 
            res[field].insert(value, index_values)
          else
            index_values.value[row_index] = true 
          end
        end
      end

      # puts 'Finish b+ tree indexes building'
      res
    end

  end
end