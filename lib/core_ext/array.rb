class Array
  def count_by(&block)
    inject(Hash.new(0)) do |counts, e|
      value = if block_given?
        block.call e
      else
        e
      end
      counts[value] += 1
      counts
    end
  end
end
