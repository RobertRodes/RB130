class Luhn
  def initialize(check_num)
    @check_num = check_num
  end

  def addends
    @check_num.digits.map.with_index do |d, i|
      if i.even?
        d
      else d * 2 > 10 ? d * 2 - 9 : d * 2
      end
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    (checksum % 10).zero?
  end

  def self.create(num)
    check_digit = (10 - new(num * 10).checksum.digits.first) % 10
    num * 10 + check_digit
  end
end

# p Luhn.create(123)
# p Luhn.create(873_956)
# p Luhn.create(837_263_756)
