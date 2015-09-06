require 'nmatrix/nmatrix'
require 'nmatrix/rowcol'

class NMatrix
  def standardize_columns!
    cols.times do |i|
      col = self[0..-1,i]
      self[0..-1,i] = (col - col.mean[0]) / col.std[0]
    end
    self
  end

  def standardize_columns
    clone.standardize_columns!
  end
end
