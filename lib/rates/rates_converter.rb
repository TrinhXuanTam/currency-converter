# frozen_string_literal: true

require 'net/http'

# frozen_string_literal: true
module Rates
  # Rates converter relative to CZK.
  class RatesConverter
    RATES_CONVERSION_SOURCE = 'https://www.cnb.cz/cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/denni_kurz.txt'

    def initialize
      # Add rate for CZK
      @rates = { CZK: 1 }
      uri = URI(RATES_CONVERSION_SOURCE)
      # Get rates from CNB
      response = Net::HTTP.get(uri)
      # Parse rates from response
      parse_rates response
    end

    def convert(value, source_currency, target_currency)
      source_currency = source_currency.to_sym.upcase
      target_currency = target_currency.to_sym.upcase

      raise ArgumentError, 'Value must be a positive number' unless value.is_a?(Numeric) && value.positive?
      raise ArgumentError, "Source currency #{source_currency} is not supported!" if @rates[source_currency].nil?
      raise ArgumentError, "Target currency #{target_currency} is not supported!" if @rates[target_currency].nil?

      # First convert source currency into CZK
      value_in_czk = value.to_f * @rates[source_currency]

      # Convert amount in CZK to target currency by CNB rates
      value_in_czk / @rates[target_currency]
    end

    def supported_currencies
      @rates.keys
    end

    private

    def parse_rates(raw_rates)
      # Split into array of lines
      lines = raw_rates.split("\n")

      # Skip headers and iterate through each line
      lines.drop(2).each do |line|
        # Split into columns
        columns = line.split('|')
        currency = columns[3].to_sym.upcase
        quantity = columns[2].to_f
        rate = columns[4].gsub(',', '.').to_f
        # Save into hash
        @rates[currency] = rate / quantity
      end
    end
  end
end
