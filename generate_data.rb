require_relative 'lib/data_generator.rb'

data_path = 'spec/fixtures/data/10m_rows.csv'
DataGenerator.new(data_path).generate