require 'csv'

class DataGenerator
  def initialize(path, n=10_000_000)
    @path = path
    @n = n
    @fields = {
      sex: 0..1,
      age: 0..100,
      height: 0..300,
      index: 0..1_000_000,
      amount: 0..1_000_000
    }
  end

  def generate
    CSV.open(@path, 'wb') do |csv|
      csv << @fields.keys
      @n.times do
        row = []
        @fields.each { |_, range| row << rand(range) }
        csv << row
      end
    end
  end
end
