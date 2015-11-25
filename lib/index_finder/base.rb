module IndexFinder
  class Base

  protected

    def combine(cond_res, res)
      if res.empty?
        cond_res
      else
        res.select! { |key, value| cond_res[key] }
        res
      end
    end

    def rows_by_keys(keys)
      keys.map { |key| @data[key] }
    end
  end
end