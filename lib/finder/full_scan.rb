module Finder
  class FullScan < Base
    def initialize(data, indexes = nil)
      @data = data
      @finder = IndexFinder::FullScan.new(data)
    end

    def find(conditions)
      @finder.find(conditions)
    end
  end
end

