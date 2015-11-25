require 'rbtree'

module IndexBuilder
  class RedBlackTree
    def initialize(data)
      @data = data
    end

    def build
      # puts 'Begin rb tree indexes building'
      res = {}
      fields = SimpleDb::FIELDS
      fields.each do |field|
        res[field] = RBTree.new
      end

      # counter = 0
      @data.each_with_index do |row, row_index|
        # puts counter if (counter % 100_000).zero?; counter += 1
        fields.each_with_index do |field, field_index|
          value = row[field_index]
          res[field][value] = {} if res[field][value].nil?
          res[field][value][row_index] = true
        end
      end

      # puts 'Finish rb tree indexes building'
      res
    end
  end
end