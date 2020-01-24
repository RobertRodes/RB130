class PhoneNumber
  def initialize(phone)
    @phone = phone
  end

  def number
    return '0000000000' unless valid_number?
    @phone.delete('^0-9')[-10..-1]
  end

  def to_s
    num = number
    "(#{num[0..2]}) #{num[3..5]}-#{num[6..9]}"
  end

  def area_code
    number[0..2]
  end

  private

  def valid_number?
    @phone =~ /^1?\(?\d{3}\)?\s?\.?\d{3}-?\.?\d{4}$/
  end
end

