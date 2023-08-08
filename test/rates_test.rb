# frozen_string_literal: true

require 'test/unit'

require_relative '../lib/rates/rates_converter'

class RatesTest < Test::Unit::TestCase
  def setup
    @converter = Rates::RatesConverter.new
    @supported_currencies = @converter.supported_currencies
  end

  def test_czk
    amount = 999
    assert_equal amount, @converter.convert(amount, 'CZK', 'CZK')
  end

  def test_invalid_amount
    assert_raise ArgumentError do
      @converter.convert(-1, 'CZK', 'CZK')
    end

    assert_raise ArgumentError do
        @converter.convert(0, 'CZK', 'CZK')
    end
    
    assert_raise ArgumentError do
        @converter.convert('invalid', 'CZK', 'CZK')
    end
  end

  def test_invalid_currency
    assert_equal 1, @converter.convert(1, 'CZK', 'CZK')
    
    assert_raise ArgumentError do
        @converter.convert(1, 'Invalid', 'CZK')
    end

    assert_raise ArgumentError do
        @converter.convert(1, 'CZK', 'Invalid')
    end
  end

  def test_currency_case
    assert_equal 1, @converter.convert(1, 'czk', 'czk')
    assert_equal 1, @converter.convert(1, 'czk', 'CZK')
    assert_equal 1, @converter.convert(1, 'CZK', 'czk')
    assert_equal 1, @converter.convert(1, 'CZK', 'CZK')
    assert_equal 1, @converter.convert(1, 'CzK', 'CzK')
  end
end
