class Integer
  def to_roman
    roman_numerals = { 
      M:1000, CM:900, D:500, CD:400, C:100, XC:90,
      L:50, XL:40, X:10, IX:9, V:5, IV:4, I:1
    }

    num = self

    roman_numerals.each_with_object('') do |(k, v), roman_numeral|
      roman_numeral << k.to_s * (num / v)
      num %= v
    end
  end
end


# p 1956.to_roman