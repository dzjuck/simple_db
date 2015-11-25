class DataLoader
  def initialize(data_path)
    @data_path = data_path
  end

  def load
    res = []
    counter = 0
    CSV.foreach(@data_path, headers: true) do |row|
      counter += 1
      row = row.fields.map(&:to_i)
      res << row
    end 
    res
  end
end