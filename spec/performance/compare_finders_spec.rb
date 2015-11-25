require 'simple_db'
require 'benchmark'
require 'terminal-table'

cache = FinderCache.new('spec/fixtures/data/1m_rows.csv')

RSpec.describe 'Compare finders performance', :performance do
  # Сохраняем время по каждому запросу для каждого finder'а
  measurements = {}
  finders = [
    Finder::FullScan, Finder::Hash, 
    Finder::RedBlackTree, 
    Finder::BPlusTree, Finder::BPlusTreeSimple
  ]

  let(:rows) { db.find(conditions) }

  finders.each do |_finder_class|
    context _finder_class do
      let(:finder_class) { _finder_class }
      let!(:db) { cache.dbs(finder_class) }

      PERFORMANCE_CONDITIONS_LIST.each_with_index do |_conditions, index|
      # SHORT_PERFORMANCE_CONDITIONS_LIST.each_with_index do |_conditions, index|
        context "run conditions ##{index}" do
          let(:conditions) { _conditions }

          it 'measure' do
            times = []
            5.times do
              # puts 'Before benchmark'
              times << Benchmark.realtime { db.find(conditions) }
              # puts 'After benchmark'
            end
            time = times.sort[1..-2].reduce(:+)/3
            # puts time
            measurements[index] = {} if measurements[index].nil?
            measurements[index][finder_class.to_s] = time
          end
        end
      end
    end
  end # finders.each do |finder_class|

  after(:all) do
    headings = ['Conditions']
    finders.each { |finder| headings << finder }

    rows = []
    time_sum = {}
    measurements.sort.to_h.each do |index, times|
      row = ["##{index}"]
      finders.each do |finder| 
        row << times[finder.to_s]

        time_sum[finder.to_s] = 0.0 if time_sum[finder.to_s].nil?
        time_sum[finder.to_s] += times[finder.to_s]
      end
      rows << row
    end

    rows << :separator
    rows << ['Total sum'] + time_sum.values

    table = Terminal::Table.new(
      title: 'Performance comparison', 
      headings: headings, rows: rows
    )

    File.write('spec/performance/report.txt', table)
    puts table
  end

end
