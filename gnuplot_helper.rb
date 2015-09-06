require 'gnuplot'

def decision_plot weights, groups
  Gnuplot::Plot.new do |plot|    
    groups.each do |data, label|
      plot.data << point_group(data, label)
    end
    
    plot.data << decision_boundary(weights)

    yield plot if block_given?
  end
end

def cost_plot errors
  Gnuplot::Plot.new do |plot|  
    plot.data << Gnuplot::DataSet.new([(1..errors.count).to_a, errors]) do |ds|
      ds.with = 'linespoints'
      ds.linewidth = 3
      ds.notitle
    end

    yield plot if block_given?
  end
end

def decision_boundary w
  # w[0] + w[1]*x + w[2]*y = 0
  # y = (-w[0] + -w[1]*x) / w[2]
  Gnuplot::DataSet.new( "(#{-w[0]} + #{-w[1]}*x) / #{w[2]}" ) do |ds|
    ds.with = "lines"
    ds.linewidth = 3
    ds.notitle
  end
end

def point_group m, title = nil
  Gnuplot::DataSet.new(m.transpose.to_a) do |ds|
    ds.with = 'points'
    title ? ds.title = title : ds.notitle
  end
end