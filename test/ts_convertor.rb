$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'test/unit'
require 'rails_currency'

class RCurrencyTest < Test::Unit::TestCase
  def test_convert
    assert_kind_of Numeric, RailsCurrency::Convertor.convert(100, "CNY", "USD")
  end

  def test_invalid_convert
    assert_raise RailsCurrency::InvalidAmountError do
      RailsCurrency::Convertor.convert("100", "CNY", "USD")
    end

    assert_raise RailsCurrency::UnknownCurrencyError do
      RailsCurrency::Convertor.convert(100, "CNY", "ABC")
    end
  end
end
