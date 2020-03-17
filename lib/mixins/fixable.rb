module Fixable

  def fix_price(row_hash)
    if row_hash['unit_price']
      row_hash['unit_price'] = row_hash['unit_price'].to_f / 100
    end
    row_hash
  end

end
