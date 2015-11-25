require 'simple_db'

RSpec.shared_examples 'finder' do |finder_class|
  let(:db) { SimpleDb.new(data_path, finder_class) }
  let(:rows) { db.find(conditions) }

  def row_to_hash(row)
    fields = [:sex, :age, :height, :index, :amount]
    row.each_with_index.map do |value, index|
      [fields[index], value]
    end.to_h
  end

  context 'manual check' do
    let(:data_path) { 'spec/fixtures/data/10_rows.csv' }
    let(:right_rows) do 
      right_rows_array
    end

    context 'equal condition' do
      let(:conditions) { [Condition::Equal.new(:sex, 0)] }
      let(:right_rows_array) do
        [
          [0,0,0,0,0],
          [0,20,60,0,0],
          [0,40,120,0,0],
          [0,60,180,0,0],
          [0,80,240,0,0]
        ]
      end

      it 'should find right rows' do
        expect(rows).to match_array(right_rows)
      end
    end

    context 'between condition' do
      let(:conditions) { [Condition::Between.new(:age, 40, 60)] }
      let(:right_rows_array) do
        [
          [0,40,120,0,0],
          [1,50,150,0,0]
        ]
      end

      it 'should find right rows' do
        expect(rows).to match_array(right_rows)
      end
    end

    context 'combined conditions' do
      let(:conditions) {
        [Condition::Equal.new(:sex, 1),
         Condition::Between.new(:height, 120, 210)]
      }
      let(:right_rows_array) do
        [ [1,50,150,0,0] ]
      end

      it 'should find right rows' do
        expect(rows).to match_array(right_rows)
      end
    end
  end # context 'manual check' do

  context 'auto check' do
    let(:data_path) { 'spec/fixtures/data/1k_rows.csv' }
    let(:data) { DataLoader.new(data_path).load }
    let(:full_scan) { IndexFinder::FullScan.new(data) }
    let(:right_rows) { full_scan.find(conditions) }

    # check every of 100 conditions list
    CONDITIONS_LIST.each_with_index do |_conditions, index|
      _conditions = CONDITIONS_LIST[index]
      context "conditions ##{index}" do
        let(:conditions) { _conditions }

        it 'should find right rows' do
          expect(rows).to match_array(right_rows)
        end
      end
    end
  end # context 'auto check' do
end
